program integral2_project;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, i2mainfunit
  { you can add units after this };

{$R *.res}

begin
  Application.Title := 'IIntegral';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TIIntegralMainForm, IIntegralMainForm);
  Application.Run;
end.

