# Realtek ALC256 — Layout IDs de Referência

> Guia rápido para testar layouts compatíveis com o codec **Realtek ALC256** neste Hackintosh AMD Ryzen 7 5700U.

---

## 📍 Configuração Atual

| Propriedade | Valor |
|-------------|-------|
| **Codec** | Realtek ALC256 (`0x10ec0256`) |
| **Caminho PCI (HDEF)** | `PciRoot(0x0)/Pci(0x8,0x1)/Pci(0x0,0x6)` |
| **Caminho PCI (HDAU - HDMI/DP)** | `PciRoot(0x0)/Pci(0x8,0x1)/Pci(0x0,0x1)` |
| **Layout Atual** | `alcid=21` |
| **Boot-args relacionados** | `alcid=21 keepsyms=1 -vi2c-force-polling unfairgva=1` |

---

## 🎧 Layout IDs para Teste (Fone de Ouvido / Combo Jack)

Caso o layout atual (`21`) não funcione corretamente com fones de ouvido ou headsets na porta combo jack, teste os seguintes layouts em ordem:

| # | Layout | Características | Base64 (`data`) |
|---|--------|-----------------|-----------------|
| 1 | **21** | Bom para notebooks combo jack (fone + mic) — *atual* | `FQAAAA==` |
| 2 | **28** | Notebooks Dell / HP / Lenovo com combo jack | `HAAAAA==` |
| 3 | **56** | Suporte a headset com microfone integrado | `OAAAAA==` |
| 4 | **66** | Notebook moderno com combo jack | `QgAAAA==` |
| 5 | **97** | ALC256-VF (variante comum em placas AMD Ryzen) | `YQAAAA==` |
| 6 | **98** | ALC256-VF alternativo | `YgAAAA==` |
| 7 | **14** | Layout genérico ALC256 (funciona speakers, headset inconsistente) | `DgAAAA==` |
| 8 | **22** | Alternativo para combo jack | `FgAAAA==` |
| 9 | **57** | Similar ao 56, notebooks Acer/ASUS | `OQAAAA==` |
| 10 | **76** | Layout para ALC256 em ultrabooks | `TAAAAA==` |

---

## 🔧 Como Alterar o Layout ID

### Opção A — Via boot-args (mais simples)

Edite o `config.plist` no caminho:
```
NVRAM → Add → 7C436110-AB2A-4BBB-A880-FE41995C9F82 → boot-args
```

Altere o valor:
```xml
<string>alcid=21 keepsyms=1 -vi2c-force-polling unfairgva=1</string>
```

Substitua `alcid=21` pelo layout desejado (ex: `alcid=28`).

### Opção B — Via DeviceProperties (recomendado)

Edite o `config.plist` no caminho:
```
DeviceProperties → Add → PciRoot(0x0)/Pci(0x8,0x1)/Pci(0x0,0x6)
```

Altere as entradas `layout-id` e `alc-layout-id` com o valor base64 correspondente.

---

## 📺 HDMI / DisplayPort Audio

| Propriedade | Valor / Status |
|-------------|----------------|
| **Dispositivo** | AMD Renoir HDMI/DP Audio (`pci1002,1637`) |
| **Driver carregado** | `AppleGFXHDA.kext` ✅ |
| **Suporte NootedRed** | Limitado / experimental |
| **Boot-arg auxiliar** | `unfairgva=1` |

> ⚠️ O áudio via HDMI/DP em APU AMD Renoir/Cezanne é uma **limitação conhecida** do projeto NootedRed. A configuração foi adicionada ao `config.plist` para tentar ativar, mas não há garantia de funcionamento completo.

---

## 🔄 Procedimento de Teste

1. Edite o `config.plist` com o novo layout
2. **Reset NVRAM** no menu de boot do OpenCore (ou `Cmd+Opt+P+R`)
3. Reinicie o macOS
4. Conecte o fone de ouvido na porta combo jack
5. Vá em **Configurações → Som → Saída** e verifique se aparece `"Headphones"` ou `"Fones de ouvido"`
6. Teste também o microfone em **Configurações → Som → Entrada**

---

## 📋 Diagnóstico Rápido

Para verificar se o codec foi detectado corretamente após o boot:

```bash
# Ver codec detectado
ioreg -rxn IOHDACodecDevice | grep -E "CodecVendorID|CodecRevisionID"

# Ver layout carregado
ioreg -l | grep "layout-id"

# Ver dispositivos de áudio
system_profiler SPAudioDataType

# Monitorar logs ao conectar fone
log stream --predicate 'eventMessage contains "audio" OR eventMessage contains "headphone"' --level debug
```

---

## 📝 Notas

- A porta de áudio deste notebook é **combo jack (4 pinos - TRRS)**: suporta fone de ouvido + microfone simultâneos. Fones com plugue TRS (3 pinos) podem não ser detectados corretamente.
- Se nenhum layout resolver a detecção do fone, pode ser necessário usar o **ALCPlugFix** ou **ComboJack** para forçar a reinicialização do codec ao conectar/desconectar.
- Sempre mantenha um backup do `config.plist` antes de fazer alterações.

---

*Gerado automaticamente em 2026-05-24*
