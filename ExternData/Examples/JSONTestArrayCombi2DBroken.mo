within ExternData.Examples;
model JSONTestArrayCombi2DBroken
  extends JSONTestVariableArrayBroken;
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds(table=[0,0; 1,1]) annotation (Placement(transformation(extent={{-48,-24},{-28,-4}})));
equation
  connect(const.y, combiTable2Ds.u1) annotation (Line(points={{-69,20},{-56,20},{-56,-8},{-50,-8}}, color={0,0,127}));
  connect(const.y, combiTable2Ds.u2) annotation (Line(points={{-69,20},{-56,20},{-56,-20},{-50,-20}}, color={0,0,127}));
end JSONTestArrayCombi2DBroken;
