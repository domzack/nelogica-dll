//******************************************************************************
//
//       Nome: ConnectorUtilsU
//  Descrição: Funções auxiliares para conversão de objetos/registros do Profit
//             para registros da interface (que utilizam estruturas simplifica-
//             das)
//
//    Criação: 14/08/2017  v1.0.1.0  Rafael Koch Peres
// Modificado:
//
//******************************************************************************
unit ConnectorUtilsU;

interface
uses
  ConnectorInterfaceU, TDataFormat, RoteamentoOrderU;

function GetAssetID(const i_tAssetID : TAssetIdentifier; out o_recAssetID : TAssetIDRec) : LongBool; overload;
function GetAssetID(const i_recAssetID : TAssetIDRec; out o_tAssetID : TAssetIdentifier) : LongBool; overload;

implementation

const EMPTY_ASSET_ID : TAssetIDRec = (pchTicker: ''; pchBolsa: ''; nFeed: 0);

//******************************************************************************
//
//       Nome: GetAssetID
//  Descrição: Converte um Profit TAssetIdentifier para um record TAssetIDRec
//             para a DLL
//
//    Criação: 14/08/2017  v1.0.1.0  Rafael Koch Peres
// Modificado:
//
//******************************************************************************
function GetAssetID(const i_tAssetID : TAssetIdentifier; out o_recAssetID : TAssetIDRec) : LongBool; overload;
begin
  o_recAssetID := EMPTY_ASSET_ID;

  o_recAssetID.pchTicker := PWideChar(i_tAssetID.strTicker);
  o_recAssetID.pchBolsa  := PWideChar(i_tAssetID.strBolsa);
  o_recAssetID.nFeed     := Ord(i_tAssetID.ftFeed);

  Result := True;
end;

//******************************************************************************
//
//       Nome: GetAssetID
//  Descrição: Converte um record TAssetIDRec para um  Profit TAssetIdentifier
//
//    Criação: 14/08/2017  v1.0.1.0  Rafael Koch Peres
// Modificado:
//
//******************************************************************************
function GetAssetID(const i_recAssetID : TAssetIDRec; out o_tAssetID : TAssetIdentifier) : LongBool; overload;
begin
  o_tAssetID.strTicker := String(i_recAssetID.pchTicker);
  o_tAssetID.strBolsa := String(i_recAssetID.pchBolsa);
  o_tAssetID.ftFeed := FeedType(i_recAssetID.nFeed);

  Result := True;
end;

end.
