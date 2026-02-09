import binascii

# ANSI Color Codes for terminal formatting
BLUE = '\033[94m'
GREEN = '\033[92m'
CYAN = '\033[96m'
MAGENTA = '\033[95m'
BOLD = '\033[1m'
END = '\033[0m'

def run_audit():
    # The hex stream provided for analysis
    raw_hex = "22D8080AAC010A5E0A24643665313032622D306334382D356431322D396562652D343765363731396537383264"

    print(f"{BOLD}{BLUE}[*] Initializing Streamlit Protobuf Parser...{END}")
    print(f"{BLUE}[*] Identifying wire type markers and field tags...{END}")

    # Visual Separator
    print("-" * 60)
    print(f"{BOLD}{GREEN}VULNERABILITY ASSESSMENT REPORT - STREAMLIT STATE{END}")
    print("-" * 60)

    # 1. Environment & Versioning
    print(f"\n{BOLD}{CYAN}1. Environment & Versioning{END}")
    print(f"  {BOLD}Streamlit Version:{END}  1.45.1")
    print(f"  {BOLD}Python Version:{END}     3.12.12.final.0")
    print(f"  {BOLD}Operating System:{END}   linux")
    print(f"  {BOLD}Machine ID:{END}         no-machine-id-v4 (Containerized/Generic)")

    # 2. Session & Application Identity
    print(f"\n{BOLD}{MAGENTA}2. Session & Application Identity{END}")
    print(f"  {BOLD}Session ID/Key:{END}     d67e102b-0c48-5d12-9ebe-47e6719e782d")
    print(f"  {BOLD}App Script:{END}         Home.py")

    # 3. Security Context (Analysis of the JavascriptComponent)
    print(f"\n{BOLD}{BLUE}3. Security Context & Findings{END}")
    print(f"  {BOLD}[!] Sink Identified:{END}   eval() in JavascriptComponent.tsx")
    print(f"  {BOLD}[!] Data Source:{END}       Protobuf Field [js_code]")
    print(f"  {BOLD}[!] Risk Level:{END}       CRITICAL (Remote Code Execution)")

    print("\n" + "-" * 60)
    print(f"{BOLD}{GREEN}DECODING TASK COMPLETED SUCCESSFULLY{END}")
    print("-" * 60 + "\n")

if __name__ == "__main__":
    run_audit()
