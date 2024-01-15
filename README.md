# TurboUpdate

TurboUpdate foi projetado para ser uma forma simples e elegante de fazer atualizações automáticas.

## ⚙️ Instalação

#### Para instalar em seu projeto usando [boss](https://github.com/HashLoad/boss):
```sh
$ boss install github.com/errorcalc/TurboUpdate
```
### Dependências

[HDmessageDlg](https://github.com/Rtrevisan20/HDMessageDlg)
[FreeEsVclComponents](https://github.com/errorcalc/FreeEsVclComponents)

#### Instalação Manual

Adicione as seguintes pastas ao seu projeto, em *Project > Options > Delphi Compiler > Search path*

```
../TurboUpdate/Source
../TurboUpdate/Source/VCL
../TurboUpdate/Source/FMX
```

#### Samples
  * Veja alguns exemplos: [samples](https://github.com/errorcalc/TurboUpdate/tree/master/Samples)

## Como usar
  * Existem algumas formas diferentes de usar o TurboUpdate. Você pode configurar ele para VCL ou FMX ou executar ele em Standalone.

#### **Uses necessárias**

```delphi
uses 
  TurboUpdate.Interfaces, 
  TurboUpdate;
``` 
## **Tipos de Uso**
### Parâmetros a serem passados
```delphi
begin
  FTurboUpdate := TTurboUpdate.New;
   FTurboUpdate
    .ExeNames(['executáveis a serem extraídos'])
    .Urls(['urls para buscar atualização'])
    .AppName('nome da chave do aquivo .ini')
    .Description('Descrição que vai aparecer na tela de atualização')
    .RootPath('Opcional')
    .PngRes('Opcional: Resolução do PNG')
    .Version(TFileVersion.CreateForFile(verão do app. EX: pode ser o executável ou número da versão, '2.0.0.0'))
    .ExecUpdateApp('App a ser executado para atualizar o sistema')
    .KillTaskApp('App a ser fechado antes de continuar com a atualização')
    .UpdateThreadVCL // Usar quando for um app de linha de comando - VCL
    .UpdateThreadFMX // Usar quando for um app de linha de comando - FMX
    .Standalone // Usar quando for chamar um app externo para fazer a atualização
    .UpdateVCL // Usar quando não chamar um app externo, nesse caso a tela de atualização será VCL 
    .UpdateFMX // Usar quando não chamar um app externo, nesse caso a tela de atualização será FMX 
    ;
end;   
```
#### Standalone
```delphi
begin
  FTurboUpdate := TTurboUpdate.New;
   FTurboUpdate
    .Urls(['https://raw.githubusercontent.com/Rtrevisan20/TurboUpdate/master/Update.ini'])
    .AppName('TurboUpdate.Vcl.Classic')
    .Version(TFileVersion.CreateForFile(ParamStr(0)))
    .ExecUpdateApp() //App a ser executado para atualizar
    .KillTaskApp(ExtractFileName(ParamStr(0))) //App a ser fechado antes da atualização
    .Standalone;
end;
```
#### Usando FMX passando o executável como parâmetro no Version 
```delphi
begin
  FTurboUpdate := TTurboUpdate.New;
  FTurboUpdate
   .ExeNames(['FmxApplication.exe'])
   .Urls(['https://raw.githubusercontent.com/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Vcl.Classic')
   .Description('TurboUpdate Atualizações...')
   .Version(TFileVersion.CreateForFile(ParamStr(0)))
   .RootPath('') //Opcional
   .PngRes('') //Opcional
   .UpdateFMX;
end;
```
#### Usando VCL 
```delphi
begin
  FTurboUpdate := TTurboUpdate.New;
  FTurboUpdate
   .ExeNames(['VclApplication.exe'])
   .Urls(['https://raw.githubusercontent.com/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Vcl.Classic')
   .Description('TurboUpdate Atualizações...')
   .Version(TFileVersion.CreateForFile(ParamStr(0)))
   .RootPath('') //Opcional
   .PngRes('') //Opcional
   .UpdateVCL;
end;
```
#### Aplicativo de console (Ainda está em teste, pode apresentar bug visual)
```delphi
  FTurboUpdate := TTurboUpdate.New;
  FTurboUpdate 
   .ExeNames(['VclApplication.exe'])
   .Urls(['https://raw.githubusercontent.com/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Vcl.Classic')
   .Description('TurboUpdate Atualizações...')
   .UpdateThreadVCL;
  Application.Run;
  ReadLn;
```