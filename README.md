# Papercut MF Application Server Container

[![GitHub](https://img.shields.io/badge/GitHub-gray?logo=github)](https://github.com/melonsmasher/papercut-mf) [![DockerHub](https://img.shields.io/badge/DockerHub-white?logo=docker)](https://hub.docker.com/r/melonsmasher/papercut-mf) [![License](https://img.shields.io/github/license/melonsmasher/papercut-mf)](https://raw.githubusercontent.com/MelonSmasher/papercut-mf/master/LICENSE)

## Description

Papercut MF application server.

## License

The code in this repository, unless otherwise noted, is licensed under the [MIT License](https://raw.githubusercontent.com/MelonSmasher/papercut-mf/master/LICENSE).

End-user licensing of the Papercut MF software is the responsibility of the end-user. Ensure that you agree to the [Papercut End-User License Agreement](https://www.papercut.com/help/manuals/ng-mf/common/license/).

## Pull

```bash
docker pull melonsmasher/papercut-mf:latest # or specific version e.g. melonsmasher/papercut-mf:20.0.4.55447
```

You can find the version number on the [Papercut MF release history page](https://www.papercut.com/products/mf/release-history/).

## Build

```bash
./build.sh <version> # e.g. ./build.sh 20.0.4.55447
```

You can find the version number on the [Papercut MF release history page](https://www.papercut.com/products/mf/release-history/).

## First Run

Clone the repo

```bash
git clone https://github.com/MelonSmasher/papercut-mf.git && cd papercut-mf
```

First, create a `.env` with the `init.sh` script.

```bash
./init.sh <version> # e.g. ./init.sh 20.0.4.55447
```

After creating the `.env` file, modify the values to match your environment.

Then, run the following command to start the container.

```bash
docker compose up -d
```

Then navigate to `http://hostname-or-ip:9191` to access the Papercut MF application server.

The default administator credentials are defined in the `.env` file as `PAPERCUT_ADMIN_USERNAME` and `PAPERCUT_ADMIN_PASSWORD`.

View them with the following command:

```bash
cat .env | grep PAPERCUT_ADMIN
```

## Upgrade

Stop the container stack.

```bash
docker compose down
```

Edit the `.env` file, change the `PAPERCUT_MF_VERSION` to the version you want to upgrade to.

Bring the container stack back up.

```bash
docker compose up -d
```

## Usage

To start the container stack.

```bash
docker compose up -d
```

To stop the container stack.

```bash
docker compose down
```

To view the logs.

```bash
docker compose logs -f
```

Papercut logs are also stored in the `vols/app/logs/` directory.

## Environment Variables in `.env`

- `DB_NAME`: The name of the database to use, leave blank for `Internal` databases.
- `DB_USER`: The username to use to connect to the database, leave blank for `Internal` databases.
- `DB_PASS`: The password to use to connect to the database, leave blank for `Internal` databases.
- `DB_HOST`: The hostname of the database server (usually the postgres container running next to it), leave blank for `Internal` databases.
- `PAPERCUT_HOSTNAME`: You can set the hostname to use for the Papercut MF application server. Default is `papercut-mf-<unix-epoch>`.
- `PAPERCUT_ADMIN_USERNAME`: The username to use for the Papercut MF application server web interface.
- `PAPERCUT_ADMIN_PASSWORD`: The password to use for the Papercut MF application server web interface.
- `PAPERCUT_DATABASE_TYPE`: The type of database to use. Default is `PostgreSQL`. Other options are:
  - `MySQL`
  - `SQLServer`
  - `Oracle`
  - `Internal`
- `PAPERCUT_DATABASE_DRIVER`: The database driver to use. Default is PostgreSQL: `org.postgresql.Driver`. Other options are:
  - MySQL: `com.mysql.cj.jdbc.Driver`
  - SQLServer: `com.microsoft.sqlserver.jdbc.SQLServerDriver`
  - Oracle: `oracle.jdbc.driver.OracleDriver`
  - Leave blank for `Internal` databases
- `PAPERCUT_DATABASE_URL`: The URL to use to connect to the database. Default is PostgreSQL: `jdbc:postgresql://$DB_HOST:5432/$DB_NAME`. Other options are:
  - MySQL: `jdbc:mysql://$DB_HOST:3306/$DB_NAME`
  - SQLServer: `jdbc:sqlserver://$DB_HOST:1433;databaseName=$DB_NAME;socketTimeout=600000`
  - Oracle: `jdbc:oracle:thin:@$DB_HOST:1521/$DB_NAME`
  - Leave blank for `Internal` databases
- `PAPERCUT_REPORTS_ENABLED`: Whether to enable the reports server. Default is `Y`, other option is `N`.
- `PAPERCUT_REPORTS_LABEL`: The label to use for the reports server. Default is `Local Site`.
- `PAPERCUT_LICENSE_BACKUP_INTERVAL_SECONDS`: The interval in seconds to backup the license. Default is `1800` which is 30 minutes.
- `PAPERCUT_FORCE_HOST_HEADER`: Set the host header value to use. Default is empty. E.G. `PAPERCUT_FORCE_HOST_HEADER=hostname.example.com`
- `PAPERCUT_LOG_WEB_REQUESTS`: Whether to log web requests. Default is `N`, other option is `Y`.
- `PAPERCUT_CSRF_CHECK_VALIDATE_REQUEST_ORIGIN`: Whether to validate the request origin. Default is `N`, other option is `Y`.
- `PAPERCUT_CSRF_CHECK_DENY_UNKNOWN_ORIGIN`: Whether to deny unknown origins. Default is `N`, other option is `Y`.
- `PAPERCUT_SSL_CERTIFICATE_CHECKS`: Whether to check SSL certificates. Default is `Y`, other option is `N`.
- `PAPERCUT_MF_VERSION`: The version of Papercut MF to use.
- `SMB_NETBIOS_NAME`: The NetBIOS name to use. Default is `papercut-mf`.
- `SMB_WORKGROUP`: The workgroup to use. Default is `WORKGROUP`.

### Version 22+ Environment Variables

From version 22 onwards, the following environment variables are available that control the security.properties file

- `PAPERCUT_SECURITY_PRINT_AND_DEVICE_SCRIPT_ENABLE`: Controls if print scripts and device scripts are enabled. Default is `N`, other option is `Y`.
- `PAPERCUT_SECURITY_PRINT_SCRIPT_ALLOW_UNSAFE_CODE`: Controls if print scripts are allowed to execute potentially unsafe code, such as calling executables or using extended Java classes. Default is `N`, other option is `Y`.
- `PAPERCUT_SECURITY_DEVICE_SCRIPT_ALLOW_UNSAFE_CODE`: Controls if device scripts are allowed to execute potentially unsafe code, such as calling executables or using extended Java classes. Default is `N`, other option is `Y`.
- `PAPERCUT_SECURITY_CARD_NO_CONVERTER_SCRIPT_PATH_ALLOW_LIST`: Controls if card converter (JavaScript) scripts are allowed to run. Default is empty. To grant access to multiple scripts, separate them with a semicolon (;). E.G. `PAPERCUT_SECURITY_CARD_NO_CONVERTER_SCRIPT_PATH_ALLOW_LIST=/path/to/script1.js;/path/to/script2.js`
- `PAPERCUT_SECURITY_CARD_NO_CONVERTER_SCRIPT_ALLOW_UNSAFE_CODE`: Controls if card converter scripts (JavaScript) are allowed to execute potentially unsafe code such as calling executables or using extended Java classes. Default is `N`, other option is `Y`.
- `PAPERCUT_SECURITY_CUSTOM_EXECUTABLE_ALLOWED_DIRECTORY_LIST`: Controls the directories where custom executables files can be executed from. Default is empty. To grant access to multiple directories, separate them with a semicolon (;). E.G. `PAPERCUT_SECURITY_CUSTOM_EXECUTABLE_ALLOWED_DIRECTORY_LIST=/path/to/directory1;/path/to/directory2`

## SMB

The container runs an SMB server that publishes a read only share that lets you access the Papercut client. This can be accessed at `\\hostname-or-ip\pc-client`.

## Migration from other server to container

Stop the Papercut MF application server on the old server.

Create the volumes directories on the new server.

```bash
mkdir -p vols/app/{conf,custom,data,reports,logs}
```

Initialize the `.env` and `docker-compose.yml` files with the `init.sh` script. The version should be exactly the same as the old server.

```bash
./init.sh <version> # e.g. ./init.sh 20.0.4.55447
```

Copy the `application.license` file from the old server to the new server and place it in the `vols/app/conf/` directory. The container will automatically import the license file on startup.

Copy the `server.uuid` file from the old server to the new server and place it in the `vols/app/conf/` directory. The container will automatically import the server uuid file on startup.

Copy the contents of the `custom/` directory from the old server to the new server and place it in the `vols/app/custom/` directory.

Copy the contents of the `data/` directory from the old server to the new server and place it in the `vols/app/data/` directory.

Copy the contents of the `reports/` directory from the old server to the new server and place it in the `vols/app/reports/` directory.

Copy the contents of the `logs/` directory from the old server to the new server and place it in the `vols/app/logs/` directory.

Take a backup of the database through the papercut web interface. Then mount the backup zip file to `/papercut/import.zip` in the docker-compose.yml file as a volume. There is an example in the `docker-compose.yml` file that is commented out.

After the docker-compose file is modified, run the following command to start the container stack.

```bash
docker compose up
```

You should notice records being imported by watching output of the container.

After the import is complete, you can stop the container stack.

Remove the volume mount for the import.zip file from the docker-compose.yml file.

Then run the following command to start the container stack again.

```bash
docker compose up -d
```

## MySQL and OracleDB

To use MySQL you'll have to [manually download the MySQL JDBC driver](https://www.papercut.com/help/manuals/ng-mf/common/ext-db-specific-my-sql/) and mount it to `/papercut/server/lib-ext/mysql-connector-java-x.y.z.jar`. You'll have to manually maintain the MySQL JDBC driver and ensure that you have the correct version for your MySQL server.

To use OracleDB you'll have to [manually download the Oracle JDBC driver](https://www.papercut.com/help/manuals/ng-mf/common/ext-db-specific-oracle/) and mount it to `/papercut/server/lib-ext/ojdbcx.jar`. You'll have to manually maintain the Oracle JDBC driver and ensure that you have the correct version for your OracleDB server.

For this reason PostgreSQL is set as the default database.
