# RoboCon 2024 Presentation Repository

This is a repository for the RoboCon 2024 presentation on Fuzzing for vulnerabilities in REST APIs. This repository contains the code samples and examples used in the conference talk (including how to use SchemathesisLibrary for API fuzzing). 

## Repository Structure

- **/flask_app**: Contains the source code for the simple website with a REST API.
- **/tests**: Includes RF keywords for checking system properties, and testcases for fuzzing of the REST API.
- **/robotframework-schemathesis**: Submodule containing the SchemathesisLibrary for API fuzzing.

## Getting Started


1. **Install Requirements**: Begin by installing all necessary dependencies listed in `requirements.txt`. You can do this using pip3:

    ```bash
    pip3 install -r requirements.txt
    ```

2. **Install Submodule**: Next, install the `robotframework-schemathesis` submodule as a pip package:

    ```bash
    pip3 install -e ./robotframework-schemathesis
    ```

3. **Run the Flask Application**: Start the Flask application by running the following command. This will launch the server and log any output to `flask_app/app.log`:

    ```bash
    python3 flask_app/app.py > flask_app/app.log 2>&1
    ```

4. **Execute Robot Framework Tests**: This command will trigger the tests located in the `tests/` directory and generate a report:

    ```bash
    mkdir output && robot --outputdir output tests
    ```

