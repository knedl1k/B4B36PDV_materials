# B4B36PDV_materials
CTU FEE Subject Parallel and distributed computing 

## Links
- page <https://pdv.pages.fel.cvut.cz/>
- 2025 playlist <https://youtube.com/playlist?list=PLQL6z4JeTTQk5k12bsaB5eU4fgCwh2ncd>
- 2024 playlist <https://youtube.com/playlist?list=PLQL6z4JeTTQmEFsy5_n2ZYNSNMPjSUyss>
- GitLab <https://gitlab.fel.cvut.cz/pdv/pdv.pages.fel.cvut.cz/-/tree/main>

## Dir Structure
```
.
├── .github/workflows/         # Složka pro automatizaci (CI/CD)
│   └── compile-pdf.yml        # Skript pro automatické zcompilování PDF
│
├── assets/                    # Veškeré externí zdroje
│   ├── images/                # Obrázky (PNG, JPG, SVG)
│   │   ├── cpp-thread-lifecycle.svg
│   │   └── java-rmi-architecture.png
│   │
│   │
│   └── code/                  # Vzorky kódu, které se vkládají do textu
│       ├── cpp/
│       │   ├── 01_hello_thread.cpp
│       │   └── 02_mutex_example.cpp
│       └── java/
│           ├── 01_rmi_server/
│           └── 02_socket_client.java
│
├── content/                   # Hlavní složka s obsahem skript
│   ├── 00-preface.typ         # Předmluva, poděkování
│   │
│   ├── part-1-cpp/            # První část: Multithreading v C++
│   │   ├── 01-intro-parallel.typ
│   │   ├── 02-threads.typ
│   │   ├── 03-synchronization.typ
│   │   └── ...
│   │
│   ├── part-2-java/           # Druhá část: Distribuované systémy v Javě
│   │   ├── 01-intro-distributed.typ
│   │   ├── 02-sockets.typ
│   │   ├── 03-rmi.typ
│   │   └── ...
│   │
│   └── 99-bibliography.bib    # Seznam literatury a zdrojů
│
├── template/                  # Templaty
│   ├── template.typ           # Template dokumentu
│   └── front.typ              # Template titulní strany
│
├── .gitignore                 # Soubor specifikující, co se nemá verzovat
├── LICENSE                    # Licence díla (např. Creative Commons)
├── main.typ                   # Hlavní soubor projektu, který vše spojuje
└── README.md                  # Popis projektu, návod na sestavení
```
## Compilation Instructions
Download CTU font *Technika* from here: https://campuscvut.sharepoint.com/:f:/r/sites/inforek-ma/ma_GrafickyManual/Jednotny%20vizualni%20styl%20CVUT/Fonty?csf=1&web=1&e=pVrmQ4 (SSO login) and put it in `/assets/fonts/`.

Then compile using
```
typst watch main.typ --font-path ~/B4B36PDV_materials/assets/fonts
```

## Useful Typst links
- *Hayagriva YAML* bib formatting <https://github.com/typst/hayagriva/blob/main/docs/file-format.md>