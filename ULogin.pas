unit ULogin;

interface



uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.Win.ADODB,comobj, Data.DB, Utilities;
type

  TFmLogin = class(TForm)
    ImLogo: TImage;
    LblUsername: TLabel;
    LblPassword: TLabel;
    EdUsername: TEdit;
    EdPassword: TEdit;
    BtnCreateNewAccount: TButton;
    BtnLogin: TButton;
    GbxLogin: TGroupBox;
    ImClose: TImage;
    LblTitle: TLabel;
    ADOCommand1: TADOCommand;
    ADOPlayer: TADOTable;
    ADOFaction: TADOTable;
    ADOMap: TADOTable;
    ADOQuery1: TADOQuery;
    ADOSettlement: TADOTable;
    procedure ImCloseClick(Sender: TObject);
    procedure BtnCreateNewAccountClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SetUpFactions(Var Faction:TFactionArray);
    procedure SetUpMaps(Var Map:TMapArray);
    procedure SetUpTiles(Var TileSet:TTileArray);
    procedure SetUpSettlements(Var Settlement:TSettlementArray);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmLogin: TFmLogin;


implementation

{$R *.dfm}

uses UCreateNewAccount, UMenu;

procedure TFmLogin.BtnCreateNewAccountClick(Sender: TObject);
begin
AdoPlayer.Close;
FmCreateNewAccount.Show;
FmLogin.Hide;
end;

procedure TFmLogin.BtnLoginClick(Sender: TObject);
var Password:string;
begin
if ((EdUsername.Text='') or (EdUsername.Text=' ')) then Showmessage('Please enter a username.')
else if ((EdPassword.Text='') or (EdPassword.Text=' ')) then Showmessage('Please enter a password.')
else
  begin
  AdoQuery1.ConnectionString:=Connstr;
  AdoQuery1.Close; //assign new SQL expression
  AdoQuery1.SQL.Clear;
  AdoQuery1.SQL.Add('Select AccountID,Passcode FROM Player WHERE Username = :User');
  ADOQuery1.Parameters.ParamByName('User').Value := EdUsername.Text;
  AdoQuery1.Open;
  AccountID := ADOQuery1.Fields[0].AsInteger;
  Password := ADOQuery1.Fields[1].AsString;
  if (Password=EdPassword.Text) then
  begin
    FmLogin.Hide;
    FmMenu.Show;
  end
  else
  begin
    Showmessage('Incorrect username or password. Please try again.');
  end;
end;
end;

procedure TFmLogin.FormActivate(Sender: TObject);
begin
  AdoPlayer.ConnectionString:= ConnStr;
  AdoPlayer.TableName:='Player';
  AdoPlayer.Open;
  AdoFaction.ConnectionString:= ConnStr;
  AdoFaction.TableName:='Faction';
  AdoFaction.Open;
  AdoMap.ConnectionString:= ConnStr;
  AdoMap.TableName:='Map';
  AdoMap.Open;
  AdoSettlement.ConnectionString:= ConnStr;
  AdoSettlement.TableName:='Settlement';
  AdoSettlement.Open;
end;

procedure TFmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
AdoPlayer.Close;
AdoFaction.Close;
AdoMap.Close;
end;

procedure TFmLogin.SetUpFactions(Var Faction:TFactionArray);
  begin
      Faction[0].Name := 'Creatures of The Depth';
      Faction[0].TypeOfFaction:= 'Militant';
      Faction[0].CapitalName := 'Eclipse';

      Faction[1].Name := 'Vikings';
      Faction[1].TypeOfFaction:= 'Militant';
      Faction[1].CapitalName := 'Roskilde';

      Faction[2].Name := 'Templars';
      Faction[2].TypeOfFaction:= 'Religious';
      Faction[2].CapitalName := 'Frostbound';

      Faction[3].Name := 'The Hive Mind';
      Faction[3].TypeOfFaction:= 'Religious';
      Faction[3].CapitalName := 'Unity';

      Faction[4].Name := 'Steampunkers';
      Faction[4].TypeOfFaction:= 'Technological';
      Faction[4].CapitalName := 'Utopia';

      Faction[5].Name := 'Dwarves';
      Faction[5].TypeOfFaction:= 'Technological';
      Faction[5].CapitalName := 'Khazad-d�m';
  end;

procedure TFmLogin.SetUpMaps(Var Map:TMapArray);
  begin
      Map[1].Name := 'Island';
      Map[1].XCoordinate:= 3;
      Map[1].YCoordinate := 1;
      Map[1].NumberOfFactions := 2;

      Map[2].Name := 'Desert';
      Map[2].XCoordinate:= 3;
      Map[2].YCoordinate := 3;
      Map[2].NumberOfFactions := 3;

      Map[3].Name := 'Jungle';
      Map[3].XCoordinate:= 5;
      Map[3].YCoordinate := 4;
      Map[3].NumberOfFactions := 4;

      Map[4].Name := 'Tundra';
      Map[4].XCoordinate:= 6;
      Map[4].YCoordinate := 3;
      Map[4].NumberOfFactions := 5;

      Map[5].Name := 'Chaos';
      Map[5].XCoordinate:= 7;
      Map[5].YCoordinate := 4;
      Map[5].NumberOfFactions := 6;
  end;

procedure TFmLogin.SetUpTiles(var TileSet:TTileArray);
  begin
      TileSet[1].Name:='Island';
      TileSet[1].TotalFood:=10;
      TileSet[1].FoodPerTurn:=3;
      TileSet[1].TotalGold:=0;
      TileSet[1].GoldPerTurn:=0;
      TileSet[1].TotalHappiness:=100;
      TileSet[1].HappinessPerTurn:=0;

      TileSet[2].Name:='Desert';
      TileSet[2].TotalFood:=1;
      TileSet[2].FoodPerTurn:=1;
      TileSet[2].TotalGold:=0;
      TileSet[2].GoldPerTurn:=0;
      TileSet[2].TotalHappiness:=100;
      TileSet[2].HappinessPerTurn:=0;

      TileSet[3].Name:='Jungle';
      TileSet[3].TotalFood:=20;
      TileSet[3].FoodPerTurn:=4;
      TileSet[3].TotalGold:=0;
      TileSet[3].GoldPerTurn:=0;
      TileSet[3].TotalHappiness:=100;
      TileSet[3].HappinessPerTurn:=0;

      TileSet[4].Name:='Tundra';
      TileSet[4].TotalFood:=5;
      TileSet[4].FoodPerTurn:=2;
      TileSet[4].TotalGold:=0;
      TileSet[4].GoldPerTurn:=0;
      TileSet[4].TotalHappiness:=100;
      TileSet[4].HappinessPerTurn:=0;
  end;

procedure TFmLogin.SetUpSettlements(Var Settlement:TSettlementArray);
  begin
      Settlement[1].Name:='Hamlet';
      Settlement[1].Paradigm:='Core';
      Settlement[1].GoldToConstruct:=5;
      Settlement[1].FoodPerTurn:=5;
      Settlement[1].GoldPerTurn:=1;

      Settlement[2].Name:='Village';
      Settlement[2].Paradigm:='Advanced';
      Settlement[2].GoldToConstruct:=10;
      Settlement[2].FoodPerTurn:=10;
      Settlement[2].GoldPerTurn:=2;

      Settlement[3].Name:='Town';
      Settlement[3].Paradigm:='Complex';
      Settlement[3].GoldToConstruct:=15;
      Settlement[3].FoodPerTurn:=15;
      Settlement[3].GoldPerTurn:=3;

      Settlement[4].Name:='City';
      Settlement[4].Paradigm:='Evolved';
      Settlement[4].GoldToConstruct:=20;
      Settlement[4].FoodPerTurn:=20;
      Settlement[4].GoldPerTurn:=4;
  end;

procedure TFmLogin.FormCreate(Sender: TObject);
var cat:OLEVariant;
  I, MaxFactions, MaxMaps, MaxSettlements: Integer;
begin
  SetUpFactions(Faction);
  SetUpMaps(Map);
  SetUpTiles(TileSet);
  SetUpSettlements(Settlement);
  MaxFactions:=5;
  MaxMaps:=5;
  MaxSettlements:=4;
  cat:=CreateOleObject('ADOX.Catalog');
  if not FileExists('Triumphant.accdb') then
    begin
      cat.create('Provider=Microsoft.ACE.OLEDB.12.0; Data Source=Triumphant.accdb;');
      ADOCommand1.ConnectionString:=ConnStr;
      //Player Table DDL
      ADOCommand1.CommandText:='CREATE TABLE Player(AccountID INTEGER,' +
                         'Username VARCHAR(40),Passcode VARCHAR(25),LastLogin DATE,' +
                         'Expert BIT,Wins INTEGER,Losses INTEGER,' +
                         'PRIMARY KEY(AccountID))';
      ADOCommand1.Execute;
      //Faction Table DDL
      ADOCommand1.CommandText:='CREATE TABLE Faction(FactionID INTEGER,' +
                         'Name VARCHAR(40),Type VARCHAR(13),CapitalName VARCHAR(20),' +
                         'PRIMARY KEY(FactionID))';
      ADOCommand1.Execute;
      //Trait Table DDL
      ADOCommand1.CommandText:='CREATE TABLE Trait(TraitID INTEGER,' +
                         'Name VARCHAR(25),Description VARCHAR(40),' +
                         'FactionID INTEGER,' +
                         'FOREIGN KEY(FactionID) REFERENCES Faction(FactionID),' +
                         'PRIMARY KEY(TraitID))';
      ADOCommand1.Execute;
      //Map Table DDL
      ADOCommand1.CommandText:='CREATE TABLE Map(MapID INTEGER,' +
                         'Name VARCHAR(9),XCoordinate INTEGER,YCoordinate INTEGER,' +
                         'NumberOfFactions INTEGER,' +
                         'PRIMARY KEY(MapID))';
      ADOCommand1.Execute;
      //SaveState Table DDL
      ADOCommand1.CommandText:='CREATE TABLE SaveState(SaveID INTEGER,' +
                         'FileName VARCHAR(25),' +
                         'AccountID INTEGER,MapID INTEGER,' +
                         'FactionID INTEGER,' +
                         'NumberOfTurns INTEGER,CurrentNumberOfFactions INTEGER,' +
                         'FOREIGN KEY(AccountID) REFERENCES Player(AccountID),' +
                         'FOREIGN KEY(MapID) REFERENCES Map(MapID),' +
                         'FOREIGN KEY(FactionID) REFERENCES Faction(FactionID),' +
                         'PRIMARY KEY(SaveID,AccountID))';
      ADOCommand1.Execute;
      //Settlement Table DDL
      ADOCommand1.CommandText:='CREATE TABLE Settlement(SettlementID INTEGER,' +
                         'Name VARCHAR(25),Paradigm VARCHAR(13),' +
                         'GoldToConstruct INTEGER,FoodPerTurn INTEGER,GoldPerTurn INTEGER,' +
                         'PRIMARY KEY(SettlementID))';
      ADOCommand1.Execute;
      //Tile Table DDL
      ADOCommand1.CommandText:='CREATE TABLE Tile(TileID CHAR(5),SaveID INTEGER,AccountID INTEGER,' +
                         'Name VARCHAR(40),' +
                         'TotalFood FLOAT,FoodPerTurn FLOAT,' +
                         'TotalGold FLOAT,GoldPerTurn FLOAT,' +
                         'TotalHappiness INTEGER,HappinessPerTurn INTEGER,' +
                         'FactionID INTEGER,MapID INTEGER,' +
                         'SettlementID INTEGER,' +
                         'FOREIGN KEY(FactionID) REFERENCES Faction(FactionID),' +
                         'FOREIGN KEY(MapID) REFERENCES Map(MapID),' +
                         'FOREIGN KEY(SettlementID) REFERENCES Settlement(SettlementID),' +
                         'FOREIGN KEY(SaveID,AccountID) REFERENCES SaveState(SaveID,AccountID),' +
                         'PRIMARY KEY(TileID,SaveID,AccountID))';
      ADOCommand1.Execute;
      //Squad Table DDL
      ADOCommand1.CommandText:='CREATE TABLE Squad(SquadID INTEGER,' +
                         'Active BIT,Objective VARCHAR(10),TurnsToComplete INTEGER,' +
                         'XCoordinate INTEGER,YCoordinate INTEGER,FactionID INTEGER,' +
                         'TileID CHAR(5),SaveID INTEGER, AccountID INTEGER,' +
                         'FOREIGN KEY(TileID,SaveID,AccountID) REFERENCES Tile(TileID,SaveID,AccountID),' +
                         'FOREIGN KEY(FactionID) REFERENCES Faction(FactionID),' +
                         'PRIMARY KEY(SquadID))';
      ADOCommand1.Execute;
      //Adds array of TFaction into factions table in database
      //maybe use array of TFaction and a for loop
      FmLogin.Activate;
      for I := 0 to MaxFactions do
        begin
          AdoFaction.Append;
          AdoFaction['FactionID']:=I;
          AdoFaction['Name']:=Faction[I].Name;
          AdoFaction['Type']:=Faction[I].TypeOfFaction;
          AdoFaction['CapitalName']:=Faction[I].CapitalName;
          AdoFaction.Post;
        end;
      //Adds array of TMap into maps table in database
      for I := 1 to MaxMaps do
        begin
          AdoMap.Append;
          AdoMap['MapID']:=I;
          AdoMap['Name']:=Map[I].Name;
          AdoMap['XCoordinate']:=Map[I].XCoordinate;
          AdoMap['YCoordinate']:=Map[I].YCoordinate;
          AdoMap['NumberOfFactions']:=Map[I].NumberOfFactions;
          AdoMap.Post;
        end;
      for I := 1 to MaxSettlements do
        begin
          AdoSettlement.Append;
          AdoSettlement['SettlementID']:=I;
          AdoSettlement['Name']:=Settlement[I].Name;
          AdoSettlement['Paradigm']:=Settlement[I].Paradigm;
          AdoSettlement['GoldToConstruct']:=Settlement[I].GoldToConstruct;
          AdoSettlement['FoodPerTurn']:=Settlement[I].FoodPerTurn;
          AdoSettlement['GoldPerTurn']:=Settlement[I].GoldPerTurn;
          AdoSettlement.Post;
        end;
    end;
end;

procedure TFmLogin.FormShow(Sender: TObject);
begin
FmLogin.Activate;
EdUsername.Text:='';
EdPassword.Text:='';
end;

procedure TFmLogin.ImCloseClick(Sender: TObject);
begin
AdoPlayer.Close;
AdoFaction.Close;
AdoMap.Close;
AdoSettlement.Close;
Close;
end;

end.
