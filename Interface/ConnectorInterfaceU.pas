//******************************************************************************
//
//       Nome: ConnectorInterfaceU
//  Descrição: Define interface para a biblioteca, com declaração de registros e
//             tipos estáticos presentes na interface
//
//    Criação:
// Modificado:
//
//******************************************************************************
unit ConnectorInterfaceU;

interface
uses
  System.Generics.Collections, Classes, HadesBasicDataTypesU, ConnectionPanelU, TDataFormat;

type
 {
  Conversão de bolsas
  BCB       = 'A';
  Bovespa   = 'B';
  CBOT      = 'C';
  Economic  = 'E';
  BMF       = 'F';
  CME       = 'M';
  Nymex     = 'N';
  Comex     = 'O';
  Pioneer   = 'P';
  SP        = 'S';
  DowJones  = 'X';
  Nyse      = 'Y';
  Cambio    = 'D';
  Unknown   = ' ';
 }
  //////////////////////////////////////////////////////////////////////////////
  // Enums
  TMarketDataConnectionState = ConnectionPanelU.ConnectionState;

  TAuthenticationResult = HadesBasicDataTypesU.TAuthenticationResult;

  TBrokerConnectionState = HadesBasicDataTypesU.TBrokerConnectionState;

  TConnActivationResult = (
    connActivatValid    = 0,
    connActivatInvalid  = 1
  );

  TConnTradeType = TDataFormat.TTradeType;

  TConnStateType = (
    connStLogin         = 0, // Info
    connStBroker        = 1, // Hades
    connStMarket        = 2, // Mercury
    connStActv          = 3
  );

  TypeChangeState = (tcsOpened=0, tcsSuspended=1, tcsFrozen=2, tcsInhibited=3, tcsAuctioned=4, tcsOpenReprogramed=5,
                     tcsClosed=6, tcsUnknown=7, tcsNightProcess=8, tcsPreparation=9, tcsPreClosing=10, tcsPromoter=11,
                     tcsEODConsulting=12, tcsPreOpening=13, tcsAfterMarket=14,tcsTrading=15,tcsImpedido=16,tcsBovespa=17,
                     tcsInterrupted=18, tcsNone=255);

  TValidityType = HadesBasicDataTypesU.TBrokerTimeInForce;
  // #Enums

  //////////////////////////////////////////////////////////////////////////////
  // Records
  ////////////////////////////////////////////////////////////////////////////
  // Asset Identifier
  PAssetIDRec = ^TAssetIDRec;
  TAssetIDRec = packed record
    pchTicker : PWideChar;
    pchBolsa  : PWideChar;
    nFeed     : Integer;
  end;

  PDataSerieIDRec = ^TDataSerieIDRec;
  TDataSerieIDRec = packed record
    pchTicker      : PWideChar;
    pchBolsa       : PWideChar;
    nFeed          : Integer;
    Level          : Integer;
    Offset         : Integer;
    Factor         : Integer;
    HasAfterMarket : Char;
    Adjusted       : Char;
  end;

  PAccountRec = ^TAccountRec;
  TAccountRec = packed record
    pchAccountID ,  pchTitular, pchNomeCorretora : PWideChar;
    nCorretoraID : Integer;
  end;

  PPositionRec = ^TPositionRec;
  TPositionRec = packed record
    //Utilizado por todas posicoes
    CorretoraId             : Integer;
    Conta, Titular, Ticker  : PWideChar;

    //Custodia
    QtdD1, QtdD2, QtdD3, QtdBloq,
    QtdPend, QtdAlloc, QtdProv,
    QtdDisp , CarteiraId    : Integer;
    DescCarteira            : PWideChar;

    //Posição aberta no Intraday
    Qtd, QtdBuy, QtdSell    : Integer;
    AvgPriceIntraday        : Double;

    //Posição no dia
    AvgPriceSellToday, AvgPriceBuyToday : Double;
  end;

  POrderRec = ^TOrderRec;
  TOrderRec = packed record
    CorretoraId, Qtd                                    : Integer;
    Price, AvgPrice                                     : Double;
    Conta, Titular, ClOrdID, Status, Ticker, Date, Side : PWideChar;
  end;

  TradeRec = record
    TAssetIDRec   : TAssetIDRec;
    dtDate        : TDateTime;
    sPrice, sVol  : Double;
    nQtd, nBuyAgent, nSellAgent, nTradeType  : Integer;
  end;
  PTradeRec = ^TradeRec;

  // #Records
  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // Callbacks
  TStateCallback           = procedure(nStateType , nActResult : Integer) stdcall;

  TAssetListCallback       = procedure(rAssetID  : TAssetIDRec; pwcName : PWideChar) stdcall;

  TAssetListInfoCallback                           = procedure(rAssetID  : TAssetIDRec;
                                                 strName, strDescription : PWideChar;
    nMinOrderQtd, nMaxOrderQtd, nLote, stSecurityType, ssSecuritySubType : Integer;
                                 sMinPriceIncrement, sContractMultiplier : Double;
                                                        strDate, strISIN : PWideChar) stdcall;

  TAssetListInfoCallbackV2                         = procedure(rAssetID  : TAssetIDRec;
                                                 strName, strDescription : PWideChar;
    nMinOrderQtd, nMaxOrderQtd, nLote, stSecurityType, ssSecuritySubType : Integer;
                                 sMinPriceIncrement, sContractMultiplier : Double;
                    strDate, strISIN, strSetor, strSubSetor, strSegmento : PWideChar) stdcall;

  TChangeCotation          = procedure(rAssetID   : TAssetIDRec;
                                        pwcDate   : PWideChar;
                                     nTradeNumber : Cardinal;
                                           sPrice : Double) stdcall;

  TChangeStateTicker       = procedure(rAssetID   : TAssetIDRec;
                                        pwcDate   : PWideChar;
                                           nState : Integer) stdcall;

  TNewTradeCallback        = procedure(rAssetID   : TAssetIDRec;
                                        pwcDate   : PWideChar;
                                     nTradeNumber : Cardinal;
                                    sPrice, sVol  : Double;
         nQtd, nBuyAgent, nSellAgent, nTradeType  : Integer;
                                          bIsEdit : Char) stdcall;

  THistoryTradeCallback     = procedure(rAssetID  : TAssetIDRec;
                                        pwcDate   : PWideChar;
                                     nTradeNumber : Cardinal;
                                    sPrice, sVol  : Double;
         nQtd, nBuyAgent, nSellAgent, nTradeType  : Integer) stdcall;

  TTinyBookCallback        = procedure(rAssetID  : TAssetIDRec;
                                       sPrice    : Double;
                                     nQtd, nSide : Integer) stdcall;

  TAdjustHistoryCallback   = procedure(                rAssetID  : TAssetIDRec;
                                                       sValue    : Double;
      strAdjustType, strObserv, dtAjuste, dtDeliber, dtPagamento : PWideChar;
                                                    nAffectPrice : Integer) stdcall;

  TAdjustHistoryCallbackV2 = procedure(                rAssetID  : TAssetIDRec;
                                                       sValue    : Double;
      strAdjustType, strObserv, dtAjuste, dtDeliber, dtPagamento : PWideChar;
                                                          nFlags : Cardinal;
                                                           dMult : Double) stdcall;

  TNewDailyCallback        = procedure(                                           rAssetID : TAssetIDRec;
                                                                                   pwcDate : PWideChar;
    sOpen, sHigh, sLow, sClose, sVol, sAjuste, sMaxLimit, sMinLimit, sVolBuyer, sVolSeller : Double;
             nQtd, nNegocios, nContratosOpen, nQtdBuyer, nQtdSeller, nNegBuyer, nNegSeller : Integer) stdcall;

  THistoryCallback         = procedure(                                         rAssetID : TAssetIDRec;
                                        nCorretora , nQtd, nTradedQtd, nLeavesQtd, nSide : Integer;
                                                           sPrice, sStopPrice, sAvgPrice : Double;
                                                                               nProfitID : Int64;
                                        TipoOrdem, Conta, Titular, ClOrdID, Status, Date : PWideChar) stdcall;

  THistoryCallbackV2       = procedure(                                         rAssetID : TAssetIDRec;
                              nCorretora, nQtd, nTradedQtd, nLeavesQtd, nSide, nValidity : Integer;
                                                           sPrice, sStopPrice, sAvgPrice : Double;
                                                                               nProfitID : Int64;
                                              TipoOrdem, Conta, Titular, ClOrdID, Status,
                                               Date, LastUpdate, CloseDate, ValidityDate : PWideChar) stdcall;

  TOrderChangeCallback     = procedure(                                         rAssetID : TAssetIDRec;
                                         nCorretora, nQtd, nTradedQtd, nLeavesQtd, nSide : Integer;
                                                           sPrice, sStopPrice, sAvgPrice : Double;
                                                                               nProfitID : Int64;
                           TipoOrdem, Conta, Titular, ClOrdID, Status, Date, TextMessage : PWideChar) stdcall;

  TOrderChangeCallbackV2   = procedure(                                         rAssetID : TAssetIDRec;
                             nCorretora , nQtd, nTradedQtd, nLeavesQtd, nSide, nValidity : Integer;
                                                           sPrice, sStopPrice, sAvgPrice : Double;
                                                                               nProfitID : Int64;
                                        TipoOrdem, Conta, Titular, ClOrdID, Status, Date,
                                        LastUpdate, CloseDate, ValidityDate, TextMessage : PWideChar) stdcall;

  TAccountCallback         = procedure( nCorretora : Integer;
     CorretoraNomeCompleto, AccountID, NomeTitular : PWideChar) stdcall;

  TPriceBookCallback        = procedure (          rAssetID : TAssetIDRec ;
                   nAction , nPosition, Side, nQtds, nCount : Integer;
                                                     sPrice : Double;
                                      pArraySell, pArrayBuy : Pointer) stdcall;

  TOfferBookCallback        = procedure (          rAssetID : TAssetIDRec ;
                     nAction, nPosition, Side, nQtd, nAgent : Integer;
                                                   nOfferID : Int64;
                                                     sPrice : Double;
       bHasPrice, bHasQtd, bHasDate, bHasOfferID, bHasAgent : Char;
                                                   pwcDate  : PWideChar;
                                      pArraySell, pArrayBuy : Pointer) stdcall;

  TTheoreticalPriceCallback = procedure (          rAssetID : TAssetIDRec;
                                          dTheoreticalPrice : Double;
                                            nTheoreticalQtd : Int64) stdcall;

  TProgressCallback         = procedure ( rAssetID  : TAssetIDRec ;
                                          nProgress : Integer) stdcall;
  // #Callbacks
  //////////////////////////////////////////////////////////////////////////////

const
  c_strDateFormat = 'dd/mm/yyyy hh:nn:ss.zzz';

  //////////////////////////////////////////////////////////////////////////////
  // Error Codes
  NL_OK                 = 000;     // OK
  NL_LOGIN_INVALID      = [1..4];  // LOGIN INVALID
  NL_ERR_INIT           = 080;     // Not initialized
  NL_ERR_INVALID_ARGS   = 090;     // Invalid arguments
  NL_ERR_INTERNAL_ERROR = 100;     // Internal error
  NL_WAITING_SERVER     = 110;     // Aguardando dados do servidor
  // #Error Codes
  //////////////////////////////////////////////////////////////////////////////

implementation

end.
