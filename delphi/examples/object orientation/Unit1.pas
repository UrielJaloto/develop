
unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type

  TForm1 = class(TForm)
    btStart: TButton;
    edTitle: TEdit;
    edAuthor: TEdit;
    edCategory: TEdit;
    edNumberPages: TEdit;
    procedure btStartClick(Sender: TObject);
    function ReadEdit (const Param1: TEdit): string;
  end;


  TPublication = class(Tobject)
  public
    FTitle: string;
    FAuthor: string;
    FNumberPages: Integer;
  end;

  TBook = class(TPublication)
  strict private
    FCategory: string;
  public
    constructor Create(const pTitle, pAuthor, pCategory: string; pNumberPages: Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.btStartClick(Sender: TObject);
var
  vLivro: Tbook;
  vTitle, vAuthor, vCategory: String;
  vNumberPages: Integer;

begin
  vTitle:= ReadEdit(edTitle);
  vAuthor:= ReadEdit(edAuthor);
  vCategory:= ReadEdit(edCategory);
  vNumberPAges:= ReadEdit(edNumberPages).ToInteger;
  ShowMessage('Title: ' + vtitle + ' / Author: ' + vAuthor + ' / Category: ' + vCategory
  + ' / Number of Pages: ' + vNumberPages.ToString);


end;

{ TLivro }

constructor Tbook.Create(const pTitle, pAuthor, pCategory: string; pNumberPAges: Integer);
begin
  FTitle := pTitle;
  FAuthor := pAuthor;
  FCategory := pCategory;
  FNumberPages := pNumberPages;
end;

function TForm1.ReadEdit(const Param1: TEdit): string;
begin
  result:= param1.text
end;

end.
