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
../TurboUpdate/Source/Language
```

#### Exemplos
  * Veja alguns exemplos: [samples](https://github.com/errorcalc/TurboUpdate/tree/master/Samples)

## Como usar
  * Existem algumas formas diferentes de usar o TurboUpdate. Você pode configurar ele para VCL ou FMX ou executar ele em Standalone.

#### **Uses necessárias para a maioria do uso**

```delphi
uses 
  TurboUpdate.Interfaces, 
  TurboUpdate;
``` 
## **Tipos de Usos**
### Parâmetros a serem passados
```delphi
begin
  FTurboUpdate := TTurboUpdate.New;
   FTurboUpdate
    .ExeNames(['executáveis a serem extraídos'])
    .Urls(['urls para buscar atualização'])
    .AppName('nome da chave do aquivo .ini')
    .Description('Descrição que vai aparecer na tela de atualização')
    .RootPath('Opcional: Nome da pasta onde deseja descompactar o executável atualizado')
    .PngRes('Opcional: Serve p/ trocar a imagem default da tela de atualização. Adicionar em Project > Resources and Images, e passar o nome do recurso. Ex: image.png')
    .Version(TFileVersion.CreateForFile(verão do app. EX: pode ser o executável ou número da versão, '2.0.0.0'))
    .ExecUpdateApp('App a ser executado para atualizar o sistema. Default: Update.exe')
    .KillTaskApp('App a ser fechado antes de continuar com a atualização. Ex: Update.exe')
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
   .RootPath('') //Pasta para descompactar - Opcional 
   .PngRes('') //Nome do Resource - Opcional
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
#### Apenas um executável sem tela
##### Abrir View Source (CTRL+V) do projeto e add:
```delphi  
uses 
  TurboUpdate;
begin    
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TTurboUpdate.New
   .ExeNames(['VclApplication.exe'])
   .Urls(['https://raw.githubusercontent.com/TurboUpdate/master/Update.ini'])
   .AppName('TurboUpdate.Vcl.Classic')
   .Description('TurboUpdate Atualizações...')
   .UpdateThreadVCL;
  Application.Run;
end.  
```