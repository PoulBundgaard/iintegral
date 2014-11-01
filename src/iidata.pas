unit iidata;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  i2int = integer;
  i2bool = boolean;
  i2float = double;
  i2str = string;

  i2text = pchar;
  TI2XML = string;

  TI2Obj = class;
  TI2Lib = class;
  TI2Doc = class;

  TI2Inf = class;
  TI2Dig = class;
  TI2Aud = class;
  TI2Vis = class;
  TI2Sns = class;
  TI2Ref = class;

  TI2DigObj = class;
  TI2Data = class;
  TI2Proc = class;
  TI2Plan = class;

  TI2AudObj = class;
  TI2Sound = class;

  TI2VisObj = class;
  TI2Grfx = class;
  TI2Video = class;

  TI2SnsObj = class;
  TI2Actn = class;

  TI2Auth = class;
  TI2Port = class;
  TI2Canal = class;
  TI2View = class;

  TI2Obj = class
  private
    FObjTop: TI2Obj;
    function get_root: TI2Obj; virtual; abstract;
    function get_name: i2str; virtual; abstract;
  protected
    procedure w_xml(d: TI2XML); virtual; abstract;
    procedure r_xml(d: TI2XML); virtual; abstract;
    procedure w_stream(s: TStream); virtual; abstract;
    procedure r_stream(s: TStream); virtual; abstract;
    property obj_top: TI2Obj read FObjTop;
    property obj_root: TI2Obj read get_root;
  public
    property obj_name: i2str read get_name;
  end;

  TI2Lib = class
  private

  public
    function FindDoc(const AParam: i2str; out ADoc: TI2Doc): i2bool; virtual; abstract;
    procedure StoreDoc(ADoc: TI2Doc); virtual; abstract;
  end;

  TI2Revision = i2int;
  TI2DateTime = i2str;
  TI2AuthPers = TI2Auth;
  TI2ChngInfo = record
    Who: TI2AuthPers;
    When: TI2DateTime;
  end;

  TI2Doc = class(TI2Obj)
  private
    FCreated: TI2ChngInfo;
    FRevision: TI2Revision;
    FModifyed: TI2ChngInfo;
  protected

  public
    function GetInf(const AParam: i2str; out AInf: TI2Inf): i2bool; virtual; abstract;
    procedure PutInf(AInf: TI2Inf); virtual; abstract;
    procedure DelInf(AInf: TI2Inf); virtual; abstract;
    property ofcreate: TI2ChngInfo read FCreated;
    property ofrev: TI2Revision read FRevision;
    property ofchng: TI2ChngInfo read FModifyed;
  end;
  TI2Refrncs = ^TI2Doc;

  TI2Auth = class(TI2Obj)
  private
    FTotalDocs: integer;
    FAuthDocs: TI2Refrncs;
  public
    property oftotal: integer read FTotalDocs;
    property ofdocs[Index: Integer]: TI2Doc;
  end;
  TI2Authrs = ^TI2Auth;

  TI2Port = class

  end;

  TI2Canal = class
  private
    FPort: TI2Port;
  protected

  public
    procedure Close; virtual; abstract;
  end;

  TI2View = class
  private
    FPort: TI2Port;
  protected

  public
    procedure Prepare; virtual; abstract;
    procedure Refresh; virtual; abstract;
  end;

  TI2InfoStates = (isDetermined, isFixed, isUpToDate);
  TI2InfoState = set of TI2InfoStates;

  TI2InfoForms = (ifDigital, ifVisual, ifAudio, ifSense);
  TI2InfoForm = set of TI2InfoForms;

  { TI2Inf }

  TI2Inf = class
  private
    FState: TI2InfoState;
    FForm: TI2InfoForm;
    function get_doc: TI2Doc; virtual; abstract;
    function get_state(Index: Integer): i2bool;
  protected
    procedure w_text(var t: i2text); virtual; abstract;
    procedure r_text(var t: i2text); virtual; abstract;
    property ofdoc: TI2Doc read get_doc;
    property ofstat: TI2InfoState read FState;
    property ofform: TI2InfoForm read FForm;
  public
    property is_const: i2bool index 1 read get_state;
    property is_updat: i2bool index 2 read get_state;
    property is_ready: i2bool index 3 read get_state;
  end;

  TI2Dig = class(TI2Inf)
  private

  protected

  public
    procedure Echo(AView: TI2View); virtual; abstract;
  end;

  TI2Aud = class(TI2Inf)
  private

  protected

  public
    procedure Play(AView: TI2View); virtual; abstract;
  end;

  TI2Vis = class(TI2Inf)
  private

  protected

  public
    procedure Show(AView: TI2View); virtual; abstract;
  end;

  TI2Sns = class(TI2Inf)
  private

  protected

  public
    procedure Feel(AView: TI2View); virtual; abstract;
  end;

  TI2Ref = class(TI2Inf)
  private
    FTarget: TI2Inf;
  protected

  public
    property toInf: TI2Inf read FTarget;
  end;

  TI2DigObj = class

  end;

  TI2DataForms = (dfString, dfText, dfXML, dfRAW);
  TI2DataForm = set of TI2DataForms;

  TI2DataType = (dtInt, dtBool, dtFloat, dtRef, dtBox);

  TI2Struct = (dsOne, dsArray, dsMatrx, dsGroup);

  TI2Data = class(TI2DigObj)
  private
    FDatType: TI2DataType;
    FDatStruct: TI2Struct;
    FDatForm: TI2DataForm;
    function as_str: i2str; virtual; abstract;
  protected
    function dat_size: i2int; virtual; abstract;
    property val_str: i2str read as_str;
  public
    property ofsize: i2int read dat_size;
    property oftype: TI2DataType read FDatType;
    property ofstruct: TI2Struct read FDatStruct;
    property ofform: TI2DataForm read FDatForm;
  end;
  TI2Records = ^TI2Data;

  TI2Oper = class

  end;
  TI2Script = ^TI2Oper;

  TI2Proc = class(TI2DigObj)
  private
    FSteps: TI2Script;
  protected

  public

  end;

  TI2Node = class

  end;

  TI2Link = class
  private
    FNodes: TI2Node;

  end;

  TI2Conctr = class
  private
    FNode: TI2Node;
    FLinks: TI2Link;
  protected

  public

  end;

  TI2Path = class

  end;


  TI2Bus = class
    FBrnchs: TI2Path;

  end;

  TI2Plan = class(TI2DigObj)
  private
    FNodes: TI2Node;
  protected

  public

  end;

  TI2AudObj = class

  end;

  TI2Sound = class(TI2AudObj)

  end;

  TI2Music = class(TI2AudObj)

  end;


  { TI2VisObj }

  TI2VisObj = class
  private
    FVisible: i2bool;
  public
    procedure Hide;
    procedure Show;
    property Visible: i2bool read FVisible;
  end;

  TI2GrUnt = i2int;

  TI2GrPnt = record
    cx, cy: TI2GrUnt;
  end;
  TI2GrCntr = ^TI2GrPnt;

  TI2GrBnds = record
    case boolean of
    true: (TL, RB: TI2GrPnt);
    false: (L, T, R, B: TI2GrUnt);
  end;

  { TI2Grfx }

  TI2Grfx = class(TI2VisObj)
  private
    FBnds: TI2GrBnds;
    FPnts: TI2GrCntr;
    function GetGrPnt(Index: Integer): TI2GrPnt;
    function GetGrHeight: TI2GrUnt;
    function GetGrWidth: TI2GrUnt;
  protected

  public
    property P: TI2GrPnt index 0 read GetGrPnt;
    property B: TI2GrBnds read FBnds;
    property H: TI2GrUnt read GetGrHeight;
    property W: TI2GrUnt read GetGrWidth;
    property C[Index: Integer]: TI2GrPnt read GetGrPnt;
  end;

  TI2Video = class(TI2VisObj)

  end;

  TI2SnsObj = class

  end;

  TI2Actn = class(TI2SnsObj)

  end;

  { TI2Blk }

  TI2Blk = class(TI2Data)
  private
    FCntItms: i2int;
    FBlcItms: TI2Records;
  protected
    function dat_size: i2int; override;
    property ofcount: i2int read FCntItms;
    //property itm_str[]: i2str read Fitm_str write Setitm_str;
  public

  end;

implementation

{ TI2VisObj }

procedure TI2VisObj.Hide;
begin
  FVisible := false;
end;

procedure TI2VisObj.Show;
begin
  FVisible := true;
end;

{ TI2Grfx }

function TI2Grfx.GetGrPnt(Index: Integer): TI2GrPnt;
begin
  result := FPnts[Index];

end;

function TI2Grfx.GetGrHeight: TI2GrUnt;
begin
  with FBnds do result := T - B;
end;

function TI2Grfx.GetGrWidth: TI2GrUnt;
begin
  with FBnds do result := R - L;
end;

{ TI2Blk }

function TI2Blk.dat_size: i2int;
begin
  result := FCntItms*0;
end;

{ TI2Inf }

function TI2Inf.get_state(Index: Integer): i2bool;
begin
  case Index of
    1: result := isFixed in FState;
    2: result := isUpToDate in FState;
    3: result := isDetermined in FState;
  end;
end;

end.

