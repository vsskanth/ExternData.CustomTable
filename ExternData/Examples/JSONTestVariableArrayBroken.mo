within ExternData.Examples;
model JSONTestVariableArrayBroken "Test custom CombiTable with variable sized array from JSON file"
  extends Modelica.Icons.Example;
  parameter String setName="set1" "Parameter set name" annotation(choices(choice="set1" "First parameter set", choice="set2" "Second parameter set"));
  inner parameter ExternData.JSONFile dataSource(fileName=Modelica.Utilities.Files.loadResource("modelica://ExternData/Resources/Examples/test.json"), detectMissingData=ExternData.Types.Diagnostics.Warning)
                                                                                                                                                       "JSON file" annotation(Placement(transformation(extent={{-80,60},{-60,80}})));
  final parameter Integer m = dataSource.getArrayRows2D("table1") "Number of rows in 2D array";
  ExternData.Tables.CombiTable1D variableSizeTable(
    tableName="table1",
    jsondata=dataSource,
    columns={2})                                     annotation(Placement(transformation(extent={{-48,10},{-28,30}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
equation
  connect(const.y, variableSizeTable.u[1]) annotation (Line(points={{-69,20},{-50,20}}, color={0,0,127}));
  annotation(experiment(
      Interval=10,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html><p>This example model reads the gain parameters from different nodes of the JSON file <a href=\"modelica://ExternData/Resources/Examples/test.json\">test.json</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.JSONFile.getReal\">ExternData.JSONFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.JSONFile.getString\">ExternData.JSONFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.JSONFile.getRealArray2D\">ExternData.JSONFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    __Dymola_experimentFlags(Advanced(
        InlineMethod=0,
        InlineOrder=2,
        InlineFixedStep=0.001)));
end JSONTestVariableArrayBroken;
