within ExternData.Examples;
model JSONTestVariableArrayWorking "Test custom CombiTable along with Modelica Table"
  extends JSONTestVariableArrayBroken;
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0,0; 1,1]) annotation (Placement(transformation(extent={{-48,-20},{-28,0}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(table=[0,0; 1,1]) annotation (Placement(transformation(extent={{-48,-50},{-28,-30}})));
equation
  connect(const.y, combiTable1Ds.u) annotation (Line(points={{-69,20},{-56,20},{-56,-10},{-50,-10}}, color={0,0,127}));
  connect(const.y, combiTable1Ds1.u) annotation (Line(points={{-69,20},{-56,20},{-56,-40},{-50,-40}}, color={0,0,127}));
end JSONTestVariableArrayWorking;
