#!/bin/bash

# Ubuntu 自动字体安装脚本
# 功能：自动安装 ./font/ 目录下的字体文件
# 目录结构：./font/fz/   - 方正字体
#         ./font/ttf/  - TTF 字体
#         ./font/otf/  - OTF 字体

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 字体目录
FONT_SOURCE_DIR="./font"
FZ_DIR="$FONT_SOURCE_DIR/fz"
TTF_DIR="$FONT_SOURCE_DIR/ttf"
OTF_DIR="$FONT_SOURCE_DIR/otf"

# 系统字体目录
USER_FONT_DIR="$HOME/.local/share/fonts"
SYSTEM_FONT_DIR="/usr/share/fonts"
BACKUP_DIR="$HOME/.fonts_backup_$(date +%Y%m%d_%H%M%S)"

# 检查脚本是否以 root 权限运行
if [[ $EUID -eq 0 ]]; then
    echo -e "${YELLOW}警告：建议以普通用户身份运行此脚本${NC}"
    echo -e "字体将被安装到系统目录: $SYSTEM_FONT_DIR"
    TARGET_FONT_DIR="$SYSTEM_FONT_DIR"
else
    echo -e "字体将被安装到用户目录: $USER_FONT_DIR"
    TARGET_FONT_DIR="$USER_FONT_DIR"
fi

# 创建目标字体目录
create_font_dir() {
    local dir_type=$1
    
    if [[ "$dir_type" == "user" ]]; then
        mkdir -p "$USER_FONT_DIR"
        echo -e "${GREEN}✓ 已创建用户字体目录: $USER_FONT_DIR${NC}"
    else
        if [[ $EUID -eq 0 ]]; then
            mkdir -p "$SYSTEM_FONT_DIR"
            echo -e "${GREEN}✓ 已创建系统字体目录: $SYSTEM_FONT_DIR${NC}"
        else
            echo -e "${YELLOW}需要 root 权限创建系统字体目录${NC}"
            return 1
        fi
    fi
    return 0
}

# 备份现有字体配置
backup_fonts() {
    echo -e "\n${BLUE}正在备份现有字体配置...${NC}"
    
    mkdir -p "$BACKUP_DIR"
    
    # 备份字体缓存
    if [ -f "$HOME/.cache/fontconfig" ]; then
        cp -r "$HOME/.cache/fontconfig" "$BACKUP_DIR/"
        echo -e "${GREEN}✓ 备份字体缓存${NC}"
    fi
    
    # 备份字体配置文件
    if [ -d "$HOME/.config/fontconfig" ]; then
        cp -r "$HOME/.config/fontconfig" "$BACKUP_DIR/"
        echo -e "${GREEN}✓ 备份字体配置文件${NC}"
    fi
    
    echo -e "${GREEN}✓ 备份完成，备份位置: $BACKUP_DIR${NC}"
}

# 检查字体源目录
check_source_dirs() {
    local dirs_exist=0
    
    echo -e "\n${BLUE}检查字体源目录...${NC}"
    
    if [ -d "$FZ_DIR" ]; then
        local fz_count=$(find "$FZ_DIR" -maxdepth 1 -name "*.ttf" -o -name "*.TTF" -o -name "*.otf" -o -name "*.OTF" 2>/dev/null | wc -l)
        echo -e "${GREEN}✓ 找到 fz 目录，包含 $fz_count 个字体文件${NC}"
        dirs_exist=$((dirs_exist + 1))
    else
        echo -e "${YELLOW}⚠  fz 目录不存在: $FZ_DIR${NC}"
    fi
    
    if [ -d "$TTF_DIR" ]; then
        local ttf_count=$(find "$TTF_DIR" -maxdepth 1 -name "*.ttf" -o -name "*.TTF" 2>/dev/null | wc -l)
        echo -e "${GREEN}✓ 找到 ttf 目录，包含 $ttf_count 个字体文件${NC}"
        dirs_exist=$((dirs_exist + 1))
    else
        echo -e "${YELLOW}⚠  ttf 目录不存在: $TTF_DIR${NC}"
    fi
    
    if [ -d "$OTF_DIR" ]; then
        local otf_count=$(find "$OTF_DIR" -maxdepth 1 -name "*.otf" -o -name "*.OTF" 2>/dev/null | wc -l)
        echo -e "${GREEN}✓ 找到 otf 目录，包含 $otf_count 个字体文件${NC}"
        dirs_exist=$((dirs_exist + 1))
    else
        echo -e "${YELLOW}⚠  otf 目录不存在: $OTF_DIR${NC}"
    fi
    
    if [ $dirs_exist -eq 0 ]; then
        echo -e "${RED}✗ 未找到任何字体目录，请检查字体源路径${NC}"
        return 1
    fi
    
    return 0
}

# 安装字体文件
install_fonts() {
    local font_type=$1
    local source_dir=$2
    local target_base_dir=$3
    
    # 为不同字体类型创建子目录
    local target_dir
    if [[ $EUID -eq 0 ]]; then
        # 系统安装：按类型分类
        target_dir="$SYSTEM_FONT_DIR/$font_type"
    else
        # 用户安装：统一目录
        target_dir="$USER_FONT_DIR"
    fi
    
    mkdir -p "$target_dir"
    
    # 统计字体数量
    local font_count=0
    local supported_extensions=("ttf" "TTF" "otf" "OTF")
    
    for ext in "${supported_extensions[@]}"; do
        for font_file in "$source_dir"/*."$ext"; do
            if [ -f "$font_file" ] 2>/dev/null; then
                cp "$font_file" "$target_dir/"
                font_count=$((font_count + 1))
                echo -e "  ✓ 安装: $(basename "$font_file")"
            fi
        done
    done
    
    if [ $font_count -gt 0 ]; then
        echo -e "${GREEN}✓ 成功安装 $font_count 个 $font_type 字体${NC}"
    fi
    
    return $font_count
}

# 更新字体缓存
update_font_cache() {
    echo -e "\n${BLUE}正在更新字体缓存...${NC}"
    
    if command -v fc-cache &> /dev/null; then
        if [[ $EUID -eq 0 ]]; then
            fc-cache -fv
        else
            fc-cache -fv "$USER_FONT_DIR"
        fi
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ 字体缓存更新成功${NC}"
        else
            echo -e "${RED}✗ 字体缓存更新失败${NC}"
            return 1
        fi
    else
        echo -e "${YELLOW}⚠ 未找到 fc-cache 命令，请安装 fontconfig:${NC}"
        echo -e "  sudo apt-get install fontconfig"
        return 1
    fi
    
    return 0
}

# 验证安装
verify_installation() {
    echo -e "\n${BLUE}验证字体安装...${NC}"
    
    local total_fonts=0
    
    if [[ $EUID -eq 0 ]]; then
        # 系统安装
        for dir in "$SYSTEM_FONT_DIR"/*/; do
            if [ -d "$dir" ]; then
                local count=$(find "$dir" -name "*.ttf" -o -name "*.TTF" -o -name "*.otf" -o -name "*.OTF" 2>/dev/null | wc -l)
                total_fonts=$((total_fonts + count))
                echo -e "  ${dir%/}: $count 个字体"
            fi
        done
    else
        # 用户安装
        if [ -d "$USER_FONT_DIR" ]; then
            total_fonts=$(find "$USER_FONT_DIR" -name "*.ttf" -o -name "*.TTF" -o -name "*.otf" -o -name "*.OTF" 2>/dev/null | wc -l)
            echo -e "  $USER_FONT_DIR: $total_fonts 个字体"
        fi
    fi
    
    echo -e "${GREEN}✓ 总共安装 $total_fonts 个字体${NC}"
}

# 显示安装摘要
show_summary() {
    echo -e "\n${BLUE}===========================${NC}"
    echo -e "${GREEN}      字体安装完成        ${NC}"
    echo -e "${BLUE}===========================${NC}"
    
    echo -e "\n${YELLOW}安装摘要:${NC}"
    echo -e "  安装目录: $TARGET_FONT_DIR"
    echo -e "  备份位置: $BACKUP_DIR"
    
    if [[ $EUID -eq 0 ]]; then
        echo -e "  安装类型: ${RED}系统级安装 (需要重启某些应用)${NC}"
        echo -e "\n${YELLOW}注意:${NC}"
        echo -e "  系统级安装可能需要重启应用程序才能看到新字体"
    else
        echo -e "  安装类型: 用户级安装"
        echo -e "\n${YELLOW}注意:${NC}"
        echo -e "  如果某些应用看不到新字体，请尝试:"
        echo -e "  1. 重启应用程序"
        echo -e "  2. 注销并重新登录"
    fi
    
    echo -e "\n${YELLOW}测试字体安装:${NC}"
    echo -e "  fc-list | grep -i '字体名'  # 替换'字体名'为实际字体名称"
    echo -e "  或使用 LibreOffice、GIMP 等软件查看可用字体"
}

# 显示帮助信息
show_help() {
    echo -e "${BLUE}Ubuntu 字体自动安装脚本${NC}"
    echo -e "用法: $0 [选项]"
    echo -e "\n选项:"
    echo -e "  -h, --help     显示此帮助信息"
    echo -e "  -s, --system   安装到系统目录 (需要sudo权限)"
    echo -e "  -u, --user     安装到用户目录 (默认)"
    echo -e "\n目录结构要求:"
    echo -e "  ./font/fz/     # 方正字体"
    echo -e "  ./font/ttf/    # TTF 字体"
    echo -e "  ./font/otf/    # OTF 字体"
    echo -e "\n示例:"
    echo -e "  $0              # 安装到用户目录"
    echo -e "  sudo $0 -s      # 安装到系统目录"
}

# 主函数
main() {
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -s|--system)
                if [[ $EUID -ne 0 ]]; then
                    echo -e "${RED}错误: 系统安装需要 root 权限${NC}"
                    echo -e "请使用: sudo $0 -s"
                    exit 1
                fi
                TARGET_FONT_DIR="$SYSTEM_FONT_DIR"
                shift
                ;;
            -u|--user)
                TARGET_FONT_DIR="$USER_FONT_DIR"
                shift
                ;;
            *)
                echo -e "${RED}未知参数: $1${NC}"
                show_help
                exit 1
                ;;
        esac
    done
    
    clear
    echo -e "${BLUE}===========================${NC}"
    echo -e "${GREEN}  Ubuntu 字体安装工具     ${NC}"
    echo -e "${BLUE}===========================${NC}\n"
    
    # 备份现有配置
    backup_fonts
    
    # 检查字体源目录
    if ! check_source_dirs; then
        exit 1
    fi
    
    # 创建字体目录
    if [[ "$TARGET_FONT_DIR" == "$USER_FONT_DIR" ]]; then
        create_font_dir "user"
    else
        create_font_dir "system"
    fi
    
    # 安装字体
    echo -e "\n${BLUE}开始安装字体...${NC}"
    
    local total_installed=0
    
    # 安装 fz 字体
    if [ -d "$FZ_DIR" ]; then
        echo -e "\n${YELLOW}[安装 fz 字体]${NC}"
        install_fonts "fz" "$FZ_DIR" "$TARGET_FONT_DIR"
        font_count=$?
        total_installed=$((total_installed + font_count))
    fi
    
    # 安装 ttf 字体
    if [ -d "$TTF_DIR" ]; then
        echo -e "\n${YELLOW}[安装 ttf 字体]${NC}"
        install_fonts "ttf" "$TTF_DIR" "$TARGET_FONT_DIR"
        font_count=$?
        total_installed=$((total_installed + font_count))
    fi
    
    # 安装 otf 字体
    if [ -d "$OTF_DIR" ]; then
        echo -e "\n${YELLOW}[安装 otf 字体]${NC}"
        install_fonts "otf" "$OTF_DIR" "$TARGET_FONT_DIR"
        font_count=$?
        total_installed=$((total_installed + font_count))
    fi
    
    if [ $total_installed -eq 0 ]; then
        echo -e "${RED}✗ 未找到任何字体文件，安装中止${NC}"
        exit 1
    fi
    
    # 更新字体缓存
    update_font_cache
    
    # 验证安装
    verify_installation
    
    # 显示摘要
    show_summary
    
    echo -e "\n${GREEN}✓ 字体安装完成！${NC}"
}

# 运行主函数
main "$@"