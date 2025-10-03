# JPetStore Demo on Aspectran

This project is a sample web application that demonstrates the integration of Aspectran with MyBatis 3, using the classic JPetStore model. It is a reimplementation of the original MyBatis JPetStore sample, showcasing how to build a database-driven web application with Aspectran.

## About this Demo

The JPetStore demo is a fully functional e-commerce application that includes features like browsing product catalogs, managing a shopping cart, and processing orders. It serves as a practical example of how to use Aspectran for building real-world web applications.

## Key Technologies

- **Framework**: Aspectran
- **Data Mapper**: MyBatis 3
- **Web Server**: Undertow (embedded)
- **Database**: H2 (embedded)

## Requirements

- Java 21 or later
- Maven 3.6.3 or later

## Building from Source

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/aspectran/aspectran-jpetstore.git
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd aspectran-jpetstore
    ```

3.  **Build the project with Maven:**
    This will compile the source code, package the application, and copy all the necessary dependencies.
    ```sh
    mvn clean package
    ```

## Running the Application

Once the project is built, you can start the application using the Aspectran Shell.

1.  **Navigate to the `bin` directory:**
    ```sh
    cd app/bin
    ```

2.  **Start the Aspectran Shell:**
    ```sh
    ./shell.sh
    ```

3.  **Access the application:**
    Open your web browser and navigate to [http://localhost:8081](http://localhost:8081).

    You can log in with the following credentials:
    - **Username**: `j2ee`
    - **Password**: `j2ee`

## Database Configuration

This application uses an in-memory H2 database by default. The database is initialized at startup with schema and data. You can access the H2 console to inspect the database at [http://localhost:8081/h2-console](http://localhost:8081/h2-console).

## License

This project is licensed under the [Apache License 2.0](LICENSE.txt).
