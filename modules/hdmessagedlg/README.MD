# HDMessageDlg

HDMessageDlg foi projetado para ser uma forma simples e elegante de exibir mensagens no delphi.

Support: rtinformatica.ti@gmail.com 

## Instalação

#### Para instalar em seu projeto usando [boss](https://github.com/HashLoad/boss):
```sh
$ boss install github.com/Rtrevisan20/HDMessageDlg
```

#### Instalação Manual

Adicione as seguintes pastas ao seu projeto, em *Project > Options > Delphi Compiler > Search path*

```
../hdmessagedlg/src
../hdmessagedlg/src/FMX
```

<!-- #### Samples
  * Veja alguns exemplos: [samples](https://github.com/dliocode/datavalidator/tree/v2/samples) -->

## Como usar

#### **Uses necessárias**

```
uses HDMessageDlg.Interfaces, HDMessageDlg;
``` 

## **Tipos de Uso**

#### **Mensagem de Alerta**

```
var
  MSG : iHDMessageDlg;
begin
  MSG := THDMessageDlg.New;  
  MSG
   .MsgTitle('Mensagem de Alerta')
   .MsgQuestion('Essa é uma mensagem de Alerta?')
   .MsgBody('Mensagem de Alerta, Mensagem de Alerta')
   .MsgIcon(iAlert)
   .MsgType(tOK)
   .DisplayMessage; 
```

#### **Mensagem de Alerta**

```
var
  MSG : iHDMessageDlg;
begin
  MSG := THDMessageDlg.New;  
  MSG
   .MsgTitle('Mensagem de Alerta')
   .MsgQuestion('Essa é uma mensagem de Alerta?')
   .MsgBody('Mensagem de Alerta, Mensagem de Alerta')
   .MsgIcon(iAlert)
   .MsgType(tOK)
   .DisplayMessage; 
```

#### **Mensagem de Atenção**

```
var
  MSG : iHDMessageDlg;
begin
  MSG := THDMessageDlg.New;  
  MSG
   .MsgTitle('Mensagem de Atenção')
   .MsgQuestion('Essa é uma mensagem de Atenção?')
   .MsgBody('Mensagem de Atenção, Mensagem de Atenção')
   .MsgIcon(iAttention)
   .MsgType(tOK)
   .DisplayMessage;
```

#### **Mensagem de Erro**

```
var
  MSG : iHDMessageDlg;
begin
  MSG := THDMessageDlg.New;  
  MSG
   .MsgTitle('Mensagem de Erro')
   .MsgQuestion('Essa é uma mensagem de Erro?')
   .MsgBody('Mensagem de Erro, Mensagem de Erro')
   .MsgIcon(iError)
   .MsgType(tOK)
   .DisplayMessage;
```

#### **Mensagem de Joia**

```
var
  MSG : iHDMessageDlg;
begin
  MSG := THDMessageDlg.New;  
  MSG
   .MsgTitle('Mensagem de Joia')
   .MsgQuestion('Essa é uma mensagem de Joia?')
   .MsgBody('Mensagem de Joia, Mensagem de Joia')
   .MsgIcon(iError)
   .MsgType(tOK)
   .DisplayMessage; 
```

#### **Apenas uma Mensagem**

```
var
  MSG : iHDMessageDlg;
begin
  MSG := THDMessageDlg.New;  
  MSG
   .MsgTitle('Essa é apenas uma Mensagem')
   .MsgQuestion('Essa é uma mensagem?')
   .MsgBody('Essa é apenas uma Mensagem, Essa é apenas uma Mensagem')
   .MsgIcon(iMessage)
   .MsgType(tOK)
   .DisplayMessage; 
```

#### **Mensagem de Pergunta**

```
var
  MSG : iHDMessageDlg;
begin
  MSG := THDMessageDlg.New;  
  MSG
   .MsgTitle('Mensagem de Pergunta')
   .MsgQuestion('Em qual opção você vai clicar?')
   .MsgBody('Escolha uma das opções por favor!')
   .MsgIcon(iMessage)
   .MsgType(tQuestion)
   .DisplayQuestion;
```