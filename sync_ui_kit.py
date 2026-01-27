import json
import os
import subprocess
import sys

def main():
    print("🔄 Syncing UI Kit...")

    if not os.path.exists(".kit_version"):
        print("❌ Error: .kit_version file not found.")
        sys.exit(1)

    try:
        with open(".kit_version", "r") as f:
            config = json.load(f)
    except json.JSONDecodeError:
        print("❌ Error: .kit_version is not valid JSON.")
        sys.exit(1)
    
    url = config.get("url")
    version = config.get("version")
    
    if not url or not version:
        print("❌ Error: .kit_version must contain 'url' and 'version'.")
        sys.exit(1)

    repo_name = url.split("/")[-1].replace(".git", "")
    target_path = f".testbed/addons/{repo_name}"

    if not os.path.exists(target_path):
        print(f"  + Cloning {repo_name}...")
        subprocess.run(["git", "clone", "--branch", version, "--depth", "1", url, target_path])
    else:
        print(f"  + {repo_name} already exists. (Delete folder to force re-sync)")

if __name__ == "__main__":
    main()