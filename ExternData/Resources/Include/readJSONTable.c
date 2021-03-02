#ifndef _READJSONTABLE_C_
#define _READJSONTABLE_C_

#include <stdio.h>
#include "ModelicaStandardTables.h"
#include "ModelicaUtilities.h"
#include "ED_JSONFile.h"

void* ModelicaStandardTables_CombiTable1D_init2_variable(void* json, const char* name, int* cols, size_t nCols, int smoothness, int extrapolation) {
	int nRow = 0; int nColumn = 0;
	ED_getArray2DDimensionsFromJSON(json, name, &nRow, &nColumn);
    ModelicaFormatMessage("nrows: %d - ncols: %d\n", nRow, nColumn);
	double *table;

	// Allocate memory for data
	table = (double*) malloc(sizeof(double)*nColumn*nRow);
	if (table) {
		ED_getDoubleArray2DFromJSON(json, name, table, nRow, nColumn);
        ModelicaFormatMessage("nrows: %d - ncols: %d\n", nRow, nColumn);
	} else {
		ModelicaError("Memory allocation error\n");
	}

	return ModelicaStandardTables_CombiTable1D_init2("NoName", "NoName",
        table, nRow, nColumn, cols, nCols, smoothness, extrapolation, 1);
}

#endif