unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ECLink, Forms, Controls, Graphics, Dialogs,
  StdCtrls, LCLIntf, ExtCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    b_doc: TButton;
    b_web: TButton;
    b_exe: TButton;
    b_exesel: TButton;
    b_docsel: TButton;
    wlink: TECLink;
    nexe: TLabeledEdit;
    ndoc: TLabeledEdit;
    nweb: TLabeledEdit;
    open_exe: TOpenDialog;
    procedure b_docClick(Sender: TObject);
    procedure b_webClick(Sender: TObject);
    procedure b_docselClick(Sender: TObject);
    procedure b_exeClick(Sender: TObject);
    procedure b_exeselClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  proceso: TProcess;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.b_docClick(Sender: TObject);
begin
  OpenDocument(ndoc.Text);
end;

procedure TForm1.b_webClick(Sender: TObject);
begin
  if nweb.Text <> '' then OpenURL(nweb.Text);
end;

procedure TForm1.b_exeClick(Sender: TObject);
begin
  proceso:= TProcess.Create(nil);
  proceso.Executable:= trim(nexe.Text); // <- Calculadora de windows
  proceso.ShowWindow:= swoMinimize;
  proceso.Execute;
  proceso.Free;
end;

procedure TForm1.b_docselClick(Sender: TObject);
begin
  open_exe.Filter:= 'Word|*.doc;*.docx|Excel|*.xls;*.xlsx|PDF|*.pdf';
  if open_exe.Execute then
  begin
    if open_exe.FileName <> '' then
    begin
      ndoc.Text:= open_exe.FileName;
      b_doc.Enabled:= true;
    end else begin
      ndoc.Text:= '';
      b_doc.Enabled:= false;
    end;
  end;
end;

procedure TForm1.b_exeselClick(Sender: TObject);
begin
  open_exe.Filter:= 'Ejecutable|*.exe';
  if open_exe.Execute then
  begin
    if open_exe.FileName <> '' then
    begin
      nexe.Text:= open_exe.FileName;
      b_exe.Enabled:= true;
    end else begin
      nexe.Text:= '';
      b_exe.Enabled:= false;
    end;
  end;
end;

end.

