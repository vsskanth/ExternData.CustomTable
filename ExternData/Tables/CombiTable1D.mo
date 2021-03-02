within ExternData.Tables;
block CombiTable1D
  "Table look-up in one dimension with variable array size from JSON"
  extends Modelica.Blocks.Interfaces.MIMOs(final n=size(columns, 1));

  parameter Real table[:, :] = fill(0.0, 0, 2)
    "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])"
    annotation (Dialog(group="Table data definition"));

  parameter String tableName=""
    "Table name on file or in function usertab (see docu)"  annotation (Dialog(group="Table data definition"));

  parameter ExternData.JSONFile jsondata "Reference to JSON data access object";

  parameter Integer columns[:]=2:size(table, 2)
    "Columns of table to be interpolated"  annotation (Dialog(group="Table data interpretation"));

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"  annotation (Dialog(group="Table data interpretation"));

  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
    "Extrapolation of data outside the definition range"  annotation (Dialog(group="Table data interpretation"));

  parameter Boolean verboseExtrapolation=false
    "= true, if warning messages are to be printed if table input is outside the definition range"  annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));

  final parameter Real u_min=Modelica.Blocks.Tables.Internal.getTable1DAbscissaUmin(tableID)
    "Minimum abscissa value defined in table";
  final parameter Real u_max=Modelica.Blocks.Tables.Internal.getTable1DAbscissaUmax(tableID)
    "Maximum abscissa value defined in table";

protected
  parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID = ExternData.Types.ExternalCombiTable1D(
      jsondata.json,
      tableName,
      columns,
      smoothness,
      extrapolation) "External table object";

      //  = ExternData.Types.ExternalCombiTable1D

equation
  assert(tableName <> "", "no table name given");

  if verboseExtrapolation and (
    extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or
    extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
    for i in 1:n loop
      assert(noEvent(u[i] >= u_min), "
Extrapolation warning: The value u["
                                   + String(i) +"] (=" + String(u[i]) + ") must be greater or equal
than the minimum abscissa value u_min (="
                                        + String(u_min) + ") defined in the table.
",
 level=AssertionLevel.warning);
      assert(noEvent(u[i] <= u_max), "
Extrapolation warning: The value u["
                                   + String(i) +"] (=" + String(u[i]) + ") must be less or equal
than the maximum abscissa value u_max (="
                                        + String(u_max) + ") defined in the table.
",
 level=AssertionLevel.warning);
    end for;
  end if;

  if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
    for i in 1:n loop
      y[i] = Modelica.Blocks.Tables.Internal.getTable1DValueNoDer(
        tableID,
        i,
        u[i]);
    end for;
  else
    for i in 1:n loop
      y[i] = Modelica.Blocks.Tables.Internal.getTable1DValue(
        tableID,
        i,
        u[i]);
    end for;
  end if;

  annotation (Diagram(graphics={        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255})}), Icon(graphics={
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255}),
    Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},{-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},{60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
    Line(points={{0,40},{0,-40}}),
    Rectangle(fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      extent={{-60,20},{-30,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      extent={{-60,0},{-30,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      extent={{-60,-20},{-30,0}},
          lineColor={0,0,0}),
    Rectangle(fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      extent={{-60,-40},{-30,-20}},
          lineColor={0,0,0})}));
end CombiTable1D;
