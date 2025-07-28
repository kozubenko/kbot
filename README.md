## 🚀 Getting Started

### ✅ Prerequisites

1. Your local machine is preconfigured with:
   - Git installed
   - Go version **≥ 1.24.5**

2. A Telegram bot is created via [BotFather](https://core.telegram.org/bots/tutorial)

### 🛠️ Steps to Run the Application Locally

```sh
# 1. Clone the repository and navigate into the project folder
git clone git@github.com:kozubenko/kbot.git
cd kbot

# 2. Install dependencies
go mod tidy

# 3. Build the app with version injection
go build -ldflags="-X=github.com/kozubenko/kbot/cmd.appVersion=v1.0.2"

# 4. Export your Telegram token
export TELE_TOKEN=your_token_here

# 5. Run the application
./kbot start

# 6. Start interacting with your bot on Telegram
