program PrTriumphantDDLFix;

uses
  Vcl.Forms,
  ULogin in 'ULogin.pas' {FmLogin},
  UCreateNewAccount in 'UCreateNewAccount.pas' {FmCreateNewAccount},
  UMenu in 'UMenu.pas' {FmMenu},
  UCreateNewGame in 'UCreateNewGame.pas' {FmCreateNewGame},
  ULoadGame in 'ULoadGame.pas' {FmLoadGame},
  UCurrentGame in 'UCurrentGame.pas' {FmCurrentGame},
  Utilities in 'Utilities.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmLogin, FmLogin);
  Application.CreateForm(TFmCreateNewAccount, FmCreateNewAccount);
  Application.CreateForm(TFmMenu, FmMenu);
  Application.CreateForm(TFmCreateNewGame, FmCreateNewGame);
  Application.CreateForm(TFmLoadGame, FmLoadGame);
  Application.CreateForm(TFmCurrentGame, FmCurrentGame);
  Application.Run;
end.
