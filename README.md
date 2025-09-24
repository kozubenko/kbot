

## **kbot** 🤖

**kbot** is a simple Telegram bot built with Go.

### **Getting Started**

To get started, you'll need to have the following prerequisites installed on your local machine.

#### **Prerequisites** ✅

  * **Git**: Make sure Git is installed to clone the repository.
  * **Go**: You'll need Go version **1.24.5** or higher.
  * **Telegram Bot Token**: Create a new bot and get your token from **BotFather** on Telegram.

#### **Running the Application Locally** 🚀

Follow these steps to set up and run the bot on your machine:

1.  **Clone the Repository**

    ```sh
    git clone git@github.com:kozubenko/kbot.git
    cd kbot
    ```

2.  **Install Dependencies**

    ```sh
    go mod tidy
    ```

3.  **Build the Application**

    ```sh
    go build -ldflags="-X=github.com/kozubenko/kbot/cmd.appVersion=v1.0.2"
    ```

4.  **Set Your Telegram Token**

    ```sh
    export TELE_TOKEN=your_token_here
    ```

5.  **Run the Bot**

    ```sh
    ./kbot start
    ```

6.  **Interact with Your Bot**

    After running the application, you can start interacting with your new bot on Telegram\!

-----

### **Makefile Description** 🛠️

This Makefile simplifies the process of building, testing, and managing Docker images for the **kbot** application across multiple platforms.

#### **Variables**

  * `APP`: The application name, automatically determined from the Git remote URL.
  * `REGISTRY`: The Docker image registry, set to `ghcr.io/kozubenko`.
  * `VERSION`: The version string, based on the latest Git tag and commit hash.

#### **Core Targets**

| Target   | Description                                           |
| :------- | :---------------------------------------------------- |
| `format` | Formats Go source code using `gofmt`.                 |
| `lint`   | Runs Go linting checks.                               |
| `get`    | Downloads all required Go module dependencies.        |
| `test`   | Executes the Go unit tests.                           |
| `build`  | Builds the `kbot` binary for the specified platform.  |
| `clean`  | Removes the built binary and all local Docker images. |
| `install_hooks` | Pre-commit hook will be installed. For now it contains gitleak check |

#### **Platform-Specific Targets**

This section shows the targets used to build the application for different operating systems.

| Target          | Platform                | Description                                |
| :-------------- | :---------------------- | :----------------------------------------- |
| `linux`         | Linux AMD64             | Builds for standard Linux machines.        |
| `macOS`         | macOS Intel (darwin/amd64)  | Builds for Intel-based Macs.               |
| `macOS_arm64`   | macOS Apple Silicon (darwin/arm64) | Builds for Apple Silicon-based Macs.       |
| `windows`       | Windows AMD64           | Builds for Windows machines.               |

#### **Docker Image Targets**

This section shows the targets used to build and push Docker images for different operating systems.

| Target                    | Action              |
| :------------------------ | :------------------ |
| `image_linux`             | Builds a Linux AMD64 Docker image.    |
| `image_macOS`             | Builds a macOS Intel Docker image.    |
| `image_macOS_arm64`       | Builds a macOS Apple Silicon Docker image.  |
| `image_windows`           | Builds a Windows AMD64 Docker image.  |
| `push_linux`              | Pushes the Linux image to the registry.      |
| `push_macOS`              | Pushes the macOS Intel image to the registry. |
| `push_macOS_arm64`        | Pushes the macOS Apple Silicon image to the registry. |
| `push_windows`            | Pushes the Windows image to the registry.      |


### **Security**
#### **GitLeaks**

We use Gitleaks for detecting and preventing hardcoded secrets like passwords, api keys, and tokens
To start using, please execute next command:

```bash
make install_hooks
```

To avoid OS inconsistencies, we use Docker. Please ensure it is installed on your local machine, otherwise the installation will fail.

Once installed, GitLeaks will automatically check your repository for secrets on every commit.
If any leaks are detected, a report will be generated at: `gitleaks-report.json`. This file is added to `.gitignore`

Please resolve any issues before committing and try again.
The configuration file can be found at: `scripts/githooks/`

For more information about GitLeaks, visit the [official GitHub repository](https://github.com/gitleaks).
