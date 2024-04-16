unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  //vallidar e formatar cpf e cnpj
  TPessoa = class abstract(TObject)
  strict protected
    FNome: string;
    FEmail: string;
    FDocumento: string;
    FDataNascimento: TDate;

    procedure SetDocumento(const Value: string); virtual;

    function GetDocumento: string; virtual; abstract;
    function ValidDocument: Boolean; virtual; abstract;
  public
    property Nome: string read FNome write FNome;
    property Email: string read FEmail write FEmail;
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
    property Documento: string read GetDocumento write SetDocumento;

  end;

  TPessoaFisica = class (TPessoa)
  strict private
    function FormatarCPF(documento: string): string;
  strict protected
    function GetDocumento: string ; override;

  end;

  TPessoaJuridica = class (TPessoa)
  strict private
    function FormatarCNPJ(documento: string): string;
  strict protected
    function GetDocumento: string; override;
  end;

  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;




var
  Form1: TForm1;

implementation

{$R *.fmx}


{ TPessoaFisica }

function TPessoaFisica.FormatarCPF(Documento: string): string;
begin
  Result := Copy(Documento,1,3)+'.'+Copy(Documento,4,3)+'.'+Copy(Documento,7,3)+'-'+Copy(Documento,10,2);
end;

function TPessoaFisica.GetDocumento: string ;
begin
  Result := FormatarCPF(Documento);
end;

{ TPessoa }

procedure TPessoa.SetDocumento(const Value: string);
begin
  FDocumento := Trim(Value);
end;

{ TPessoaJuridica }

function TPessoaJuridica.FormatarCNPJ(Documento: string): string;
begin
  Result :=Copy(Documento,1,2)+'.'+Copy(Documento,3,3)+'.'+Copy(Documento,6,3)+
  '/'+ Copy(Documento,9,4)+'-'+Copy(documento,13,2);
end;

function TPessoaJuridica.GetDocumento: string;
begin
  Result := FormatarCnpj(Documento);
end;

end.
