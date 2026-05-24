# Hackintosh AMD Ryzen 7 5700U OpenCore EFI

> **EFI OpenCore para laptops AMD Ryzen 7 5700U (Renoir/Cezanne) com iGPU Vega e Wi-Fi Intel.**
>
> Compatível com macOS Ventura 13, Sonoma 14 e Sequoia 15.

---

## 📌 Índice

- [Visão Geral](#-visão-geral)
- [Especificações do Hardware](#-especificações-do-hardware)
- [O que Funciona](#-o-que-funciona)
- [O que Não Funciona](#-o-que-não-funciona)
- [Versões](#-versões)
- [Instalação Recomendada](#-instalação-recomendada)
- [Configuração do BIOS](#-configuração-do-bios)
- [Kexts Incluídas](#-kexts-incluídas)
- [SSDTs Utilizados](#-ssdts-utilizados)
- [SMBIOS](#-smbios)
- [Agradecimentos](#-agradecimentos)
- [Contato](#-contato)

---

## 🖥️ Visão Geral

Esta EFI foi desenvolvida para **laptops baseados no processador AMD Ryzen 7 5700U**, utilizando o bootloader **OpenCore** para executar o macOS em hardware não-Apple.

O Ryzen 7 5700U é uma APU da arquitetura **Renoir/Cezanne** com gráficos integrados **AMD Radeon Vega**. Graças ao projeto [NootedRed](https://github.com/ChefKissInc/NootedRed), é possível obter aceleração gráfica completa da iGPU no macOS.

> ⚠️ **Atenção:** Esta EFI é destinada a fins educacionais. A instalação do macOS em hardware não-Apple viola os Termos de Serviço da Apple.

---

## ⚙️ Especificações do Hardware

| Componente | Modelo |
|------------|--------|
| **CPU** | AMD Ryzen 7 5700U (8C/16T, Zen 2 / Renoir) |
| **iGPU** | AMD Radeon Vega Series (Renoir/Cezanne) |
| **Áudio** | Realtek ALC (layout-id: `13`) |
| **Wi-Fi** | Intel Wireless (AirportItlwm) |
| **Bluetooth** | Intel Bluetooth (IntelBluetoothFirmware) |
| **Ethernet** | Realtek RTL8111 |
| **Touchpad** | I2C HID (VoodooI2C) |
| **Teclado** | PS/2 (VoodooPS2) |
| **Bateria** | Suporte via SMCBatteryManager |
| **Sensor de Luz** | Suporte via SMCLightSensor |
| **Storage** | NVMe (com NVMeFix) / SATA AHCI |
| **USB** | USB 3.0 / XHCI (GenericUSBXHCI + USBToolBox) |

---

## ✅ O que Funciona

- [x] **Aceleração Gráfica** — iGPU AMD Vega com suporte completo via NootedRed
- [x] **Áudio** — Saída de áudio interno e fones de ouvido (AppleALC, layout 13)
- [x] **Wi-Fi** — Redes wireless Intel via AirportItlwm
- [x] **Bluetooth** — Pairing e conectividade Bluetooth Intel
- [x] **Ethernet** — Cabo de rede Realtek RTL8111
- [x] **USB** — Todas as portas USB mapeadas
- [x] **Touchpad** — Gestos multi-touch via VoodooI2C + VoodooI2CHID
- [x] **Teclado** — Teclas de função, brilho e mídia
- [x] **Bateria** — Leitura de porcentagem e status
- [x] **Sensor de Luz Ambiente** — Ajuste automático de brilho
- [x] **NVMe/SATA** — Discos reconhecidos com TRIM e gerenciamento de energia
- [x] **Sleep/Wake** — Suspensão e retorno funcionais

---

## ❌ O que Não Funciona

- [ ] **HDMI/DP Audio** — Áudio via portas de vídeo não é suportado nativamente em APU AMD
- [ ] **AirDrop / Handoff** — Limitado pelo driver Wi-Fi Intel (não é nativo Broadcom)
- [ ] **Sidecar** — Pode não funcionar corretamente sem GPU dedicada compatível

---

## 🔢 Versões

| Componente | Versão |
|------------|--------|
| OpenCore | 1.0.x (configurado para Ventura/Sonoma/Sequoia) |
| macOS Suportado | Ventura 13.x / Sonoma 14.x / Sequoia 15.x |
| NootedRed | 0.8.10 |
| Lilu | 1.7.3 |
| VirtualSMC | 1.3.8 |
| AppleALC | 1.9.8 |
| AirportItlwm | 2.3.0 |

---

## 📥 Instalação Recomendada

> **⚠️ Recomendação importante:** A forma mais estável de instalação é seguir este fluxo:

### Passo 1: Instale o macOS Ventura 13
- Baixe a imagem de instalação do **macOS Ventura 13** (13.6.x recomendado).
- Crie um pendrive bootável com o [OpenCore Legacy Patcher](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/) ou o script oficial da Apple.
- Copie esta EFI para a partição `EFI` do pendrive.
- Instale o Ventura 13 no SSD/HDD.

### Passo 2: Configure o pós-instalação
- Após a instalação, copie esta EFI para a partição EFI do disco interno.
- Execute os patches pós-instalação se necessário (NootedRed requer inicialização em modo seguro desabilitado para kexts não-assinadas).

### Passo 3: Atualize para Sonoma 14 ou Sequoia 15
- Com o Ventura 13 rodando estável, faça a atualização pelo **System Settings → General → Software Update**.
- **Não atualize diretamente da instalação limpa** — a atualização OTA (Over-The-Air) a partir de um sistema funcional é muito mais segura.

### Boot-args recomendados
```
-v debug=0x100 keepsyms=1 -vi2c-force-polling
```

> 💡 Dica: Remova `-v` após confirmar que tudo funciona para ocultar o modo verbose.

---

## 🔧 Configuração do BIOS

Certifique-se de configurar o BIOS/UEFI do seu laptop antes de iniciar:

| Opção | Valor |
|-------|-------|
| **Secure Boot** | `Disabled` |
| **SATA Mode** | `AHCI` |
| **Above 4G Decoding** | `Enabled` (se disponível) |
| **Re-Size BAR** | `Disabled` |
| **CSM (Compatibility Support Module)** | `Disabled` |
| **Fast Boot** | `Disabled` |
| **VT-d / IOMMU** | `Disabled` |
| **TPM** | `Disabled` ou `Firmware TPM` |

> ⚠️ **Nota:** A nomenclatura exata varia entre fabricantes (Lenovo, HP, Dell, Acer, ASUS, etc.). Consulte o manual da placa-mãe.

---

## 📦 Kexts Incluídas

| Kext | Versão | Função |
|------|--------|--------|
| `Lilu.kext` | 1.7.3 | Framework de patches essencial |
| `VirtualSMC.kext` | 1.3.8 | Emulação SMC (sensores e boot) |
| `NootedRed.kext` | 0.8.10 | Suporte gráfico iGPU AMD Renoir/Cezanne |
| `AppleALC.kext` | 1.9.8 | Áudio nativo Realtek |
| `AirportItlwm.kext` | 2.3.0 | Wi-Fi Intel nativo |
| `IntelBluetoothFirmware.kext` | 2.5.0 | Firmware Bluetooth Intel |
| `IntelBTPatcher.kext` | 2.5.0 | Patches para Bluetooth Intel |
| `BlueToolFixup.kext` | 2.7.3 | Fix para stack Bluetooth no macOS 12+ |
| `RealtekRTL8111.kext` | 2.4.2 | Ethernet Realtek |
| `NVMeFix.kext` | 1.1.4 | Gerenciamento de energia NVMe |
| `SMCBatteryManager.kext` | 1.3.8 | Leitura de bateria |
| `SMCLightSensor.kext` | 1.3.8 | Sensor de luz ambiente |
| `BrightnessKeys.kext` | 1.0.4 | Teclas de brilho |
| `VoodooPS2Controller.kext` | 2.3.8 | Teclado e trackpad PS/2 |
| `VoodooI2C.kext` | 2.9.1 | Framework I2C |
| `VoodooI2CHID.kext` | 1.0 | Dispositivos I2C HID |
| `USBToolBox.kext` | 1.2.0 | Mapeamento de portas USB |
| `UTBDefault.kext` | 1.0 | Default map para USBToolBox |
| `GenericUSBXHCI.kext` | 1.3.0b2 | Driver XHCI genérico |
| `CtlnaAHCIPort.kext` | 341.0.2 | Suporte SATA AHCI |
| `ForgedInvariant.kext` | 1.5.0 | Fix para CPU AMD |
| `AppleMCEReporterDisabler.kext` | 1.2 | Desabilita MCE Reporter (AMD) |
| `RestrictEvents.kext` | 1.1.7 | Restrições de eventos do sistema |

---

## 🧩 SSDTs Utilizados

| SSDT | Função |
|------|--------|
| `SSDT-ALS0.aml` | Sensor de luz ambiente falso (para funcionamento do brilho automático) |
| `SSDT-EC.aml` | Embbeded Controller falso para macOS |
| `SSDT-PLUG-ALT.aml` | Gerenciamento de energia da CPU (alternativo para AMD) |
| `SSDT-PNLF.aml` | Backlight/Brilho da tela |
| `SSDT-USB-Reset.aml` | Reset de controladoras USB problemáticas |
| `SSDT-USBX.aml` | Configuração de power para portas USB |
| `SSDT-XOSI.aml` | Spoof de OSI para compatibilidade ACPI |

> **Patch ACPI aplicado:** `_OSI to XOSI` rename.

---

## 🔐 SMBIOS

Esta EFI utiliza o SMBIOS **`MacBookPro16,2`**.

> ⚠️ **Importante:** Você deve gerar seus próprios dados de serialização antes de usar esta EFI. Nunca use os valores genéricos incluídos neste repositório.

Utilize o [**GenSMBIOS**](https://github.com/corpnewt/GenSMBIOS) para gerar:
- `SystemProductName`: MacBookPro16,2
- `SystemSerialNumber`
- `SystemUUID`
- `MLB` (Board Serial)
- `ROM`

### Como gerar:
```bash
python3 GenSMBIOS.py
# Escolha a opção 1 para download, depois opção 3 para generate
# Insira o modelo: MacBookPro16,2
# Gere 1 serial
```

Cole os valores gerados no `config.plist`:
- `PlatformInfo → Generic`

---

## 🙏 Agradecimentos

- [Acidanthera](https://github.com/acidanthera) — OpenCore, Lilu, AppleALC, VirtualSMC e mais.
- [ChefKissInc / NootedRed](https://github.com/ChefKissInc/NootedRed) — Suporte gráfico AMD APU.
- [OpenIntelWireless](https://github.com/OpenIntelWireless) — AirportItlwm e IntelBluetoothFirmware.
- [Dortania](https://dortania.github.io/) — OpenCore Install Guide.
- [corpnewt](https://github.com/corpnewt) — GenSMBIOS e ferramentas essenciais.

---

## 📧 Contato

Tem dúvidas, sugestões ou encontrou algum problema?

**Entre em contato:** [deztyz@gmail.com](mailto:deztyz@gmail.com)

---

## ⚖️ Licença

Este projeto é disponibilizado "como está", sem garantias. Todo o código e kexts pertencem aos seus respectivos autores. O uso desta EFI é de responsabilidade do usuário final.

---

*Hackintosh AMD Ryzen 7 5700U EFI — OpenCore — macOS Ventura / Sonoma / Sequoia*
