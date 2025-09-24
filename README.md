# Um simples Bootloader de 16-bits em Assembly ( Experimental )

Este é um projeto de estudo em **Assembly** que implementa um bootloader bem simples.
Ele inicializa o processador no **Real Mode**, imprime mensagens na tela usando a **BIOS** (`int 10`) e tenta carregar setores do disco via `int 13h`.

## Funções
Configuração de segmentos (`DS`, `ES`, `SS`) e pilha.
Rotina de impressão de strings na tela (`printf`).
Leitura de setores do Hard Disk com interrupções de BIOS.

## Código-fonte
O arquivo `bootloader.asm` contém o seguinte fluxo:
* Inicialização do ambiente de 16-bits
* Impressão da mensagem de boot
* Em caso de sucesso: 
    * salto para o endereço carregado (`1000h:0000h`).
* Em caso de erro:
    * impressão de mensagem e loop infinito.

## Montagem (Compilação)
```bash
~$ yasm -f bin -o bootloader.asm bootloader.bin
``` 
[imagem do resultado](#./imagens/compilando.png)

## Executando
O projeto utiliza o compilador [Yasm](https://yasm.tortall.net/). Para compilaR:
```bash
qemu-system-i386 -hda bootloader.bin
```
**Resultado:**
[Imagem do bootloader em execução](#./imagens/bootloader.png)
