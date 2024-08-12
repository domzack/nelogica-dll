﻿unit functionWrapperU;

interface

uses
  callbackTypeU;

const
{$IFDEF CPUX64}
  DLLPath = 'ProfitDLL64.dll';
{$ELSE}
  DLLPath = 'ProfitDLL.dll';
{$ENDIF}

{$IFDEF DEBUG}
function SetServerAndPortRoteamento(strServer, strPort: PWideChar) : ShortInt; stdcall; external DLLPath;
{$ENDIF}

function DLLInitializeLogin(
    const pwcActivationKey : PWideChar;
    const pwcUser          : PWideChar;
    const pwcPassword      : PWideChar;
    StateCallback          : TStateCallback;
    HistoryCallback        : THistoryCallback;
    OrderChangeCallback    : TOrderChangeCallback ;
    AccountCallback        : TAccountCallback;
    NewTradeCallback       : TNewTradeCallback;
    NewDailyCallback       : TNewDailyCallback;
    PriceBookCallback      : TPriceBookCallback;
    OfferBookCallback      : TOfferBookCallback;
    HistoryTradeCallback   : THistoryTradeCallback;
    ProgressCallback       : TProgressCallback;
    TinyBookCallback       : TTinyBookCallback
    ) : ShortInt; stdcall; external DLLPath;
function DLLInitializeMarketLogin(
    const pwcActivationKey : PWideChar;
    const pwcUser          : PWideChar;
    const pwcPassword      : PWideChar;
    StateCallback          : TStateCallback;
    NewTradeCallback       : TNewTradeCallback;
    NewDailyCallback       : TNewDailyCallback;
    PriceBookCallback      : TPriceBookCallback;
    OfferBookCallback      : TOfferBookCallback;
    HistoryTradeCallback   : THistoryTradeCallback;
    ProgressCallback       : TProgressCallback;
    TinyBookCallback       : TTinyBookCallback
    ) : ShortInt; stdcall; external DLLPath;
function DLLFinalize : ShortInt; stdcall; external DLLPath;
function FreePointer(pPointer :Pointer; nStart : Integer) : ShortInt; stdcall; external DLLPath;
function SubscribeTicker(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function UnsubscribeTicker(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function SubscribePriceBook(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function UnsubscribePriceBook(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function SubscribeOfferBook(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function UnsubscribeOfferBook(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function GetAgentNameByID(nID : Integer) : PWideChar; stdcall; external DLLPath;
function GetAgentShortNameByID(nID : Integer) : PWideChar; stdcall; external DLLPath;
function SendBuyOrder(pwcIDAccount, pwcIDCorretora, sSenha, pwcTicker, pwcBolsa : PWideChar;
                                                                         nPrice : Double;
                                                                        nAmount : integer) : Int64; stdcall; external DLLPath;
function SendSellOrder(pwcIDAccount, pwcIDCorretora, sSenha, pwcTicker, pwcBolsa : PWideChar;
                                                                          nPrice : Double;
                                                                         nAmount : integer) : Int64; stdcall; external DLLPath;
function SendStopBuyOrder(pwcIDAccount, pwcIDCorretora, sSenha, pwcTicker, pwcBolsa : PwideChar;
                                                                 sPrice, sStopPrice : Double;
                                                                            nAmount : integer) : Int64; stdcall; external DLLPath;
function SendStopSellOrder(pwcIDAccount, pwcIDCorretora, sSenha, pwcTicker,pwcBolsa : PwideChar;
                                                                 sPrice, sStopPrice : Double;
                                                                            nAmount : integer) : Int64; stdcall; external DLLPath;
function SendChangeOrder(pwcIDAccount, pwcIDCorretora, sSenha, pwcstrClOrdID : PWideChar;
                                                                      nPrice : Double;
                                                                     nAmount : Integer) : ShortInt; stdcall; external DLLPath;
function SendCancelOrder(pwcIDAccount, pwcIDCorretora, pwcClOrdId, pwcSenha: PWideChar) :ShortInt; stdcall; external DLLPath;
function SendCancelOrders(pwcIDAccount, pwcIDCorretora, pwcSenha, pwcTicker, pwcBolsa: PWideChar) : ShortInt; stdcall; external DLLPath;
function SendCancelAllOrders(pwcIDAccount, pwcIDCorretora, pwcSenha: PWideChar) : ShortInt; stdcall; external DLLPath;
function SendZeroPosition(pwcIDAccount, pwcIDCorretora, pwcTicker, pwcBolsa, pwcSenha : PWideChar; sPrice : Double) : Int64; stdcall; external DLLPath;
function SendZeroPositionAtMarket(pwcIDAccount, pwcIDCorretora, pwcTicker, pwcBolsa, pwcSenha : PWideChar) : Int64; stdcall; external DLLPath;
function SendMarketSellOrder(pwcIDAccount, pwcIDCorretora, sSenha, pwcTicker, pwcBolsa: PWideChar; nAmount: integer) : Int64; stdcall; external DLLPath;
function SendMarketBuyOrder(pwcIDAccount, pwcIDCorretora, sSenha, pwcTicker, pwcBolsa: PWideChar; nAmount: integer) : Int64; stdcall; external DLLPath;
function GetAccount : ShortInt; stdcall; external DLLPath;
function GetOrders(pwcIDAccount, pwcIDCorretora, dtStart, dtEnd : PWideChar) : ShortInt; stdcall; external DLLPath;
function GetOrder(pwcClOrdId : PWideChar) : ShortInt; stdcall; external DLLPath;
function GetOrderProfitID(nProfitId : Int64) : ShortInt; stdcall; external DLLPath;
function GetPosition(pwcIDAccount, pwcIDCorretora, pwcTicker, pwcBolsa: PWideChar) : Pointer; stdcall; external DLLPath;
function GetHistoryTrades(const pwcTicker : PWideChar; const pwcBolsa : PWideChar; dtDateStart, dtDateEnd : PWideChar) : ShortInt; stdcall; external DLLPath;
function GetSerieHistory(const pwcTicker : PWideChar; const pwcBolsa : PWideChar; dtDateStart, dtDateEnd : PWideChar; const nQuoteNumberStart, nQuoteNumberEnd : Cardinal) : ShortInt; stdcall; external DLLPath;
function SetDayTrade(bUseDayTrade : Integer) : ShortInt; stdcall; external DLLPath;
function SetChangeCotationCallback(ChangeCotation : TChangeCotation) : ShortInt; stdcall; external DLLPath;
function SetAssetListCallback(AssetListCallback : TAssetListCallback) : ShortInt; stdcall; external DLLPath;
function SetAssetListInfoCallback(AssetListInfoCallback : TAssetListInfoCallback) : ShortInt; stdcall; external DLLPath;
function SetAssetListInfoCallbackV2(AssetListInfoCallbackV2 : TAssetListInfoCallbackV2) : ShortInt; stdcall; external DLLPath;
function SetEnabledLogToDebug(bEnabled : Integer) : ShortInt; stdcall; external DLLPath;
function RequestTickerInfo(const pwcTicker : PWideChar; const pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function GetAllTicker(pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function SetChangeStateTickerCallback(ChangeState : TChangeStateTicker) : ShortInt; stdcall; external DLLPath;
function SetEnabledHistOrder(bEnabled : Integer) : ShortInt; stdcall; external DLLPath;
function SubscribeAdjustHistory(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function UnsubscribeAdjustHistory(pwcTicker : PWideChar; pwcBolsa : PWideChar) : ShortInt; stdcall; external DLLPath;
function SetAdjustHistoryCallback(AdjustHistory : TAdjustHistoryCallback) : ShortInt; stdcall; external DLLPath;
function SetAdjustHistoryCallbackV2(AdjustHistory : TAdjustHistoryCallbackV2) : ShortInt; stdcall; external DLLPath;
function SetTheoreticalPriceCallback(TheoreticalPrice : TTheoreticalPriceCallback) : ShortInt; stdcall; external DLLPath;
function SetServerAndPort(const strServer, strPort : PWideChar) : ShortInt; stdcall; external DLLPath;
function GetServerClock(                                          var dtDate : Double;
                        var nYear, nMonth, nDay, nHour, nMin, nSec, nMilisec : Integer) : ShortInt; stdcall; external DLLPath;
function GetLastDailyClose(const pwcTicker, pwcBolsa : PWideChar;
                                          var dClose : Double;
                                           bAdjusted : Integer) : ShortInt; stdcall external DLLPath;
function SetHistoryCallbackV2(HistoryCallbackV2 : THistoryCallbackV2) : ShortInt; stdcall; external DLLPath;
function SetOrderChangeCallbackV2(OrderChangeCallbackV2 : TOrderChangeCallbackV2) : ShortInt; stdcall; external DLLPath;

implementation

end.
