{******************************************************************************}
{                           ErrorSoft TurboUpdate                              }
{                          ErrorSoft(c)  2016-2017                             }
{                                                                              }
{                     More beautiful things: errorsoft.org                     }
{                                                                              }
{           errorsoft@mail.ru | vk.com/errorsoft | github.com/errorcalc        }
{              errorsoft@protonmail.ch | habrahabr.ru/user/error1024           }
{                                                                              }
{             Open this on github: github.com/errorcalc/TurboUpdate            }
{                                                                              }
{ You can order developing vcl/fmx components, please submit requests to mail. }
{ Вы можете заказать разработку VCL/FMX компонента на заказ.                   }
{******************************************************************************}
unit TurboUpdate.Consts;
{$I \Language.inc}

interface

uses
  Data.DB,

  System.Classes,
  System.SysUtils,

  TurboUpdate.LanguagePTbr,
  TurboUpdate.LanguageUS,
  TurboUpdate.Types;

type
  TFactoryConsts = class (TInterfacedObject, IFactoryConsts)
    private
    {$IFDEF EN-Us}
      FLanguageUS : IMessageConsts;
    {$ENDIF}
    {$IFDEF PT-Br}
      FLanguadePTbr : IMessageConsts;
    {$ENDIF}
    public
      constructor Create;
      destructor Destroy; override;
      class function New : IFactoryConsts;
      function Consts : IMessageConsts;
  end;

implementation

{ TFactoryConsts }

function TFactoryConsts.Consts: IMessageConsts;
begin
{$IFDEF EN-Us}
  FLanguageUS := TMessageConstsUS.New;
  Result := FLanguageUS;
{$ENDIF}

{$IFDEF PT-Br}
  FLanguadePTbr := TMessageConstsPTbr.New;
  Result := FLanguadePTbr;
{$ENDIF}
end;

constructor TFactoryConsts.Create;
begin

end;

destructor TFactoryConsts.Destroy;
begin

  inherited;
end;

class function TFactoryConsts.New: IFactoryConsts;
begin
  Result := Self.Create;
end;

end.
