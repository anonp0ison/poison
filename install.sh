clear
echo "
██████╗  ██████╗ ██╗███████╗ ██████╗ ███╗   ██╗
██╔══██╗██╔═══██╗██║██╔════╝██╔═══██╗████╗  ██║
██████╔╝██║   ██║██║███████╗██║   ██║██╔██╗ ██║
██╔═══╝ ██║   ██║██║╚════██║██║   ██║██║╚██╗██║
██║     ╚██████╔╝██║███████║╚██████╔╝██║ ╚████║
╚═╝      ╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
";

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/poison"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/poison"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.poison"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory poison was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/poison*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/poison*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/anonp0ison" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/anonp0ison"
    else
        sudo rm -rf "$ETC_DIR/anonp0ison"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/anonp0ison/poison "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/poison.py" '${1+"$@"}' > "$INSTALL_DIR/poison";
chmod +x "$INSTALL_DIR/poison";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/poison" "$BIN_DIR"
    cp "$INSTALL_DIR/poison.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/poison" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/poison.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/poison";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing poison !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
