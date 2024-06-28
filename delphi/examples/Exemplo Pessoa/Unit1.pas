 unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox;

type

  TTipoPessoa = (tpNaoDefinido, tpFisica, tpJuridica);


  TPessoa = class abstract(TObject)

  strict private
    function GetIdade: Integer;

  strict protected
    FNome: string;
    FEmail: string;
    FDocumento: string;
    FDataNascimento: TDate;
    FTipoPessoa: TTipoPessoa;

    procedure SetNome(const Value: string);
    procedure SetDocumento(const Value: string); 
    procedure SetEmail(const Value: string);
    procedure InformarErroDocumento();

    function ValidarDocumento(const Value: string): Boolean; virtual; abstract;
    function GetDocumento: string; virtual;


  public
    property Nome: string read FNome write SetNome;
    property Email: string read FEmail write SetEmail;
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
    property Documento: string read GetDocumento write SetDocumento;
    property idade: Integer read GetIdade;
    property TipoPessoa: TTipoPessoa read FTipoPessoa;

  end;


  TPessoaFisica = class (TPessoa)

  strict private
    function FormatarCPF(const pDocumento: string): string;
    function ValidarDocumento (const pDocumento: string): Boolean; override;
    
  strict protected
    function GetDocumento: string ; override;

  public
    constructor Create;

  end;


  TPessoaJuridica = class (TPessoa)
  
  strict private
    function FormatarCNPJ(const pDocumento: string): string;
    function ValidarDocumento (const pDocumento: string): Boolean; override;
    
  strict protected
    function GetDocumento: string; override;

  public
    constructor Create;

  end;


  TForm1 = class(TForm)

    btStart: TButton;
    edNome: TEdit;
    edDataNascimento: TEdit;
    edDocumento: TEdit;
    edEmail: TEdit;
    lbNome: TLabel;
    lbDocumento: TLabel;
    lbEmail: TLabel;
    lbDataNascimento: TLabel;
    btLimparGrid: TButton;
    sgTabela: TStringGrid;
    scNome: TStringColumn;
    scDocumento: TStringColumn;
    scEmail: TStringColumn;
    scNascimento: TStringColumn;
    scIdade: TStringColumn;
    procedure btLimparGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btStartClick(Sender: TObject);

  strict private
    procedure LimparGrid();
    procedure AdicionarLinha(const LinhasAtuais: Integer);
    procedure RemoverLinha(const LinhasAtuais: Integer);
    procedure GravaDados();

    function IdentificaTipoPessoa(const pDocumento: string): TTipoPessoa;
    
  private
    function CriarPessoa(const pTipoPessoa: TTipoPessoa): TPessoa;

  end;



var
  Form1: TForm1;

implementation

uses
  system.DateUtils;

{$R *.fmx}


{ TPessoaFisica }

constructor TPessoaFisica.create;
begin
  inherited Create;
  FTipoPessoa := tpFisica;
end;

function TPessoaFisica.FormatarCPF(const pDocumento: string): string;
begin
  Result := Copy(pDocumento,1,3)+'.'+Copy(pDocumento,4,3)+'.'+Copy(pDocumento,7,3)+'-'+Copy(pDocumento,10,2);
end;

function TPessoaFisica.GetDocumento: string ;
begin
  Result := inherited GetDocumento;
  Result := FormatarCPF(Result);
end;


function TPessoaFisica.ValidarDocumento(const pDocumento: string): Boolean;
var
  vDigito10, vDigito11: string;
  vSoma, vDivisao, vPeso: integer;
begin
  if ((pDocumento = '00000000000') or (pDocumento = '11111111111') or
  (pDocumento = '22222222222') or (pDocumento = '33333333333') or
  (pDocumento = '44444444444') or (pDocumento = '55555555555') or
  (pDocumento = '66666666666') or (pDocumento = '77777777777') or
  (pDocumento = '88888888888') or (pDocumento = '99999999999') or
  (length(pDocumento) <> 11)) then
  begin
    Result := False;
    exit
  end;
  
  try
    vSoma := 0;
    vPeso := 10;
    for var i := 1 to 9 do
    begin
       vSoma := vSoma + (StrToInt(pDocumento[i]) * vPeso);
        vPeso := vPeso - 1;
      end;
    vDivisao := 11 - (vSoma mod 11);
    if ((vDivisao = 10) or (vDivisao = 11))
       then vDigito10 := '0'
    else str(vDivisao:1, vDigito10);
    vSoma := 0;
    vPeso := 11;
    for var i := 1 to 10 do
    begin
      vSoma := vSoma + (StrToInt(pDocumento[i]) * vPeso);
      vPeso := vPeso - 1;
    end;
    vDivisao := 11 - (vSoma mod 11);
    if ((vDivisao = 10) or (vDivisao = 11))
       then vDigito11 := '0'
    else str(vDivisao:1, vDigito11);
    if ((vDigito10 = pDocumento[10]) and (vDigito11 = pDocumento[11])) then
    begin
      Result := True;
      exit;
    end
    
    else 
    begin
      Result := False;
    end;
    
  except
    begin
      Result := False;
      exit;
    end;
    
  end;
end;


{ TPessoa }

function TPessoa.GetDocumento: string;
begin
  Result := FDocumento;
end;

function TPessoa.GetIdade: Integer;
var vHoje: TDateTime;
begin
  vHoje := Now;
  result:= YearsBetween(Trunc(vHoje), FDataNascimento);

end;

procedure TPessoa.InformarErroDocumento();
begin
  raise Exception.Create('Documento Invalido');
end;

procedure TPessoa.SetDocumento(const Value: string);
begin
  FDocumento := Value.Trim;
  if not ValidarDocumento(FDocumento) then
    InformarErroDocumento;
end;

procedure TPessoa.SetEmail(const Value: string);
begin
  FEmail:= Value.Trim;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value.Trim;
end;


{ TPessoaJuridica }

constructor TPessoaJuridica.Create;
begin
  inherited Create;
  FTipoPessoa := tpJuridica;
end;

function TPessoaJuridica.FormatarCNPJ(const pDocumento: string): string;
begin
  Result :=Copy(pDocumento,1,2)+'.'+Copy(pDocumento,3,3)+'.'+Copy(pDocumento,6,3)+
  '/'+ Copy(pDocumento,9,4)+'-'+Copy(pdocumento,13,2);
end;

function TPessoaJuridica.GetDocumento: string;
begin
  Result := inherited GetDocumento;
  Result := FormatarCNPJ(Result);
end;

function TPessoaJuridica.ValidarDocumento(const pDocumento: string): Boolean;
var
vDigito13, vDigito14: string;
vSoma, vDivisao, vPeso: integer;
begin
  if ((pDocumento = '00000000000000') or (pDocumento = '11111111111111') or
   (pDocumento = '22222222222222') or (pDocumento = '33333333333333') or
   (pDocumento = '44444444444444') or (pDocumento = '55555555555555') or
   (pDocumento = '66666666666666') or (pDocumento = '77777777777777') or
   (pDocumento = '88888888888888') or (pDocumento = '99999999999999') or
   (length(pDocumento) <> 14)) then
   begin
    Result:= False;
    exit;
   end;
  try
    vSoma := 0;
    vPeso := 2;
    for var vDigito := 12 downto 1 do
    begin
       vSoma := vSoma + (StrToInt(pDocumento[vDigito]) * vPeso);
      vPeso := vPeso + 1;
      if (vPeso = 10)then
        vPeso := 2;
    end;
    vDivisao := vSoma mod 11;
    if ((vDivisao = 0) or (vDivisao = 1)) then
      vDigito13 := '0'
    else str((11-vDivisao):1, vDigito13);
    vSoma := 0;
    vPeso := 2;
    for var vDigito := 13 downto 1 do
    begin
      vSoma := vSoma + (StrToInt(pDocumento[vDigito]) * vPeso);
      vPeso := vPeso + 1;
      if (vPeso = 10) then
        vPeso := 2;
      vDivisao := vSoma mod 11;
      if ((vDivisao = 0) or (vDivisao = 1)) then
        vDigito14 := '0'
    else str((11-vDivisao):1, vDigito14);
    end;
    if ((vDigito13 = pDocumento[13]) and (vDigito14  = pDocumento[14])) then
      begin
        Result := true;
        exit;
      end
        
    else
      begin
        Result := False;
        exit
      end;
      
  except
    Result := False;
  end;
end;

procedure TForm1.AdicionarLinha(const LinhasAtuais: Integer);
begin
  sgTabela.RowCount := LinhasAtuais + 1;
end;

procedure TForm1.btLimparGridClick(Sender: TObject);
begin
  LimparGrid;
end;

procedure TForm1.btStartClick(Sender: TObject);
begin
  GravaDados();
end;

function TForm1.CriarPessoa(const pTipoPessoa: TTipoPessoa): TPessoa;
begin
  case pTipoPessoa of
    tpFisica: result:= TPessoaFisica.Create; 
    tpJuridica: result:= TPessoaJuridica.Create;
    
  else  
    raise Exception.Create('O tipo de pessoa está indefinido');
  end;
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
  LimparGrid;
end;

procedure TForm1.GravaDados;
var
  vPessoa: TPessoa;
  vLinhasAtuais: integer;
  vTipoPessoa: TTipoPessoa;
begin
  vTipoPessoa := IdentificaTipoPessoa(edDocumento.Text);
  vPessoa := CriarPessoa(vTipoPessoa);
  vLinhasAtuais := sgTabela.RowCount;
  
  try
    try
      vPessoa.Documento := edDocumento.Text;
      vPessoa.Nome := edNome.Text;
      vPessoa.Email := edEmail.Text;
      vPessoa.DataNascimento := StrToDate(edDataNascimento.Text.Trim);
      AdicionarLinha(vLinhasAtuais);
      sgTabela.Cells[1, vLinhasAtuais] := vPessoa.Documento;
      sgTabela.Cells[0, vLinhasAtuais] := vPessoa.Nome;
      sgTabela.Cells[2, vLinhasAtuais] := vPessoa.Email;
      sgTabela.Cells[3, vLinhasAtuais] := DateToStr(vPessoa.DataNascimento);
      sgTabela.Cells[4, vLinhasAtuais] := vPessoa.idade.ToString;

    except
      on e: Exception do
      begin
        RemoverLinha(vLinhasAtuais);
        e.Message := 'erro: ' + e.Message;
        raise;
      end;
    end;
  
  finally
    vPessoa.Free;
  
  end;

end;

function TForm1.IdentificaTipoPessoa(const pDocumento: string): TTipoPessoa;
begin
  case pDocumento.Length of
    11: result := tpFisica;
    14: result := tpJuridica;
    
  else
    raise Exception.Create('Erro: Quantidade de caracteres inválida');
  end;
end;

procedure TForm1.LimparGrid;
begin
  sgTabela.RowCount := 0;
end;

procedure TForm1.RemoverLinha(const LinhasAtuais: Integer);
begin
  sgTabela.RowCount := LinhasAtuais - 1;
end;

end.
