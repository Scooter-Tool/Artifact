"""Module containing helper functions used by path mode."""

import os
from typing import List

# pylint: disable= no-name-in-module
from solc_select.solc_select import (
    switch_global_version,
    installed_versions,
    get_installable_versions,
)
from slither.exceptions import SlitherError
from diffusc.utils.classes import ContractData
from diffusc.utils.crytic_print import CryticPrint
from diffusc.utils.slither_provider import FileSlitherProvider
from diffusc.utils.helpers import (
    get_pragma_versions_from_file,
    get_compilation_unit_name,
)
from diffusc.core.code_generation import CodeGenerator
from get_slither_instance import get_slither_instance_from_crytic_export


def get_contracts_from_comma_separated_paths(
    paths_string: str, output_dir: str, provider: FileSlitherProvider, suffix: str = ""
) -> List[ContractData]:
    """Get multiple ContractData objects from a comma-separated list of paths."""
    contracts = []
    filepaths = paths_string.split(",")

    for path in filepaths:
        contract_data = get_contract_data_from_path(path, output_dir, provider, suffix)
        contracts.append(contract_data)
    return contracts


def get_contract_data_from_path(
    filepath: str, output_dir: str, provider: FileSlitherProvider, suffix: str = "", name: str = "", solc_version: str = ""
) -> ContractData:
    """Get a ContractData object from file path, including Slither object."""
    contract_data = ContractData()  # type: ignore[typeddict-item]

    CryticPrint.print_message(f"* Getting contract data from {filepath}")

    # contract_data["path"] = filepath
    contract_data["suffix"] = suffix
    contract_data["address"] = None
    # version = None 
    # contract_data["solc_version"] = version
    # if version in installed_versions() or version in get_installable_versions():
    #     switch_global_version(version, True)

    try:
        contract_data["slither"] = get_slither_instance_from_crytic_export(filepath, name, solc_version)
        contract_data["valid_data"] = True
    except SlitherError as err:
        CryticPrint.print_error("  * Error getting Slither object")
        raise SlitherError(str(err)) from err



    if contract_data["valid_data"]:
        slither_object = contract_data["slither"]
        if name:
            contract_name = name 
        else:
            contract_name = get_compilation_unit_name(slither_object)
            print("Did not provide contract name, extract it", contract_name)
        try:
            contract = slither_object.get_contract_from_name(contract_name)[0]
        except IndexError:
            raise SlitherError(f"Contract {contract_name} not found in {filepath}")
            contract = slither_object.get_contract_from_name(
                contract_name.replace("V1", "").replace("V2", "").replace("V3", "")
            )[0]
        contract_data["contract_object"] = contract
        abs_path = contract.file_scope.filename.absolute
        rel_path = os.path.relpath(abs_path, output_dir)
        contract_data["path"] = rel_path
        contract_data = CodeGenerator.get_valid_contract_data(contract_data)
        CryticPrint.print_message(f"  * Done compiling contract {contract_data['name']}")

    return contract_data
