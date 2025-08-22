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
├── .github/workflows/         # CI/CD
│   └── compile-pdf.yml        # automatically compile PDF
│
├── assets/                    
│   ├── images/                # all types of images
│   │   ├── info-boxes/        # icons used within info boxes
│   │   │   ├── circle-info.svg
│   │   │   └── ...
│   │   ├── a.svg
│   │   ├── b.png
│   │   └── ...
│   │
│   └── code/                  # code examples used in document
│       ├── cpp/
│       │   ├── 01_hello_thread.cpp
│       │   └── 02_mutex_example.cpp
│       └── java/
│           ├── 01_rmi_server/
│           └── 02_socket_client.java
│
├── content/                   # main directory
│   ├── 00-preface.typ         # preface, acknowledgments, used technologies
│   │
│   ├── part-1-cpp/            # multithreading in C++
│   │   ├── 01-intro-parallel.typ
│   │   ├── 02-threads.typ
│   │   ├── 03-synchronization.typ
│   │   └── ...
│   │
│   ├── part-2-java/           # distributed systems in Java
│   │   ├── 01-intro-distributed.typ
│   │   ├── 02-sockets.typ
│   │   ├── 03-rmi.typ
│   │   └── ...
│   │
│   └── 99-bibliography.yml    # bibliography and sources
│
├── template/                  # templates
│   ├── template.typ           # document specific
│   ├── colors.typ             # colors used in the document and templates
│   ├── info-boxes.typ         # information boxes
│   ├── outline.typ            # better Table of Contents  
│   └── front.typ              # front page
│
├── .gitignore                 
├── LICENSE                    
├── main.typ                   # The main project file that connects everything
└── README.md                  # Project description, compile instructions, useful links
```
<!-- ## Compilation Instructions
Download CTU font *Technika* from here: https://campuscvut.sharepoint.com/:f:/r/sites/inforek-ma/ma_GrafickyManual/Jednotny%20vizualni%20styl%20CVUT/Fonty?csf=1&web=1&e=pVrmQ4 (SSO login) and put it in `/assets/fonts/`.

Then compile using
```
typst watch main.typ --font-path ~/B4B36PDV_materials/assets/fonts
``` -->

## Useful Typst links
- *Hayagriva YAML* bib formatting <https://github.com/typst/hayagriva/blob/main/docs/file-format.md>