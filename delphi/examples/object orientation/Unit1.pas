
unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type

  TForm1 = class(TForm)
    btStart: TButton;
    edTitulo: TEdit;
    edAutor: TEdit;
    edCategoria: TEdit;
    edNumeroPaginas: TEdit;
    pnDisplay: TPanel;
    procedure btStartClick(Sender: TObject);
    function LerEdit (const Param1: TEdit): string;
  end;


  TPublicacao = class(Tobject)
  public
    FTitulo: string;
    FAutor: string;
    FNumeroPaginas: Integer;
  end;

  TLivro = class(TPublicacao)
  strict private
    FCategoria: string;
  public
    constructor Create(const pTitulo, pAutor, pCategoria: string; pNurmeoPaginas: Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.btStartClick(Sender: TObject);
var
  vLivro: TLivro;
  vTitulo, vAutor, vCategoria: String;
  vNumeroPaginas: Integer;
  vPanel: TPanel;
begin
  vTitulo:= LerEdit(edTitulo);
  vAutor:= LerEdit(edAutor);
  vCategoria:= LerEdit(edCategoria);
  vNumeroPaginas:= LerEdit(edNumeroPaginas).ToInteger;
  vPanel:= TPanel.Create(pnDisplay);


end;

{ TLivro }

constructor TLivro.Create(const pTitulo, pAutor, pCategoria: string; pNurmeoPaginas: Integer);
begin
  FTitulo := pTitulo;
  FAutor := pAutor;
  FCategoria := pCategoria;
  FNumeroPaginas := pNurmeoPaginas;
end;

function TForm1.LerEdit(const Param1: TEdit): string;
begin
  result:= param1.text
end;

end.
