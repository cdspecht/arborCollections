{
    "inputs": [
        {
            "description": "Data table that includes both variables that you want (and other things perhaps)",
            "format": "rows",
            "id": "table",
            "name": "table",
            "type": "table"
        },
        {
            "description": "Column name for independent variable",
            "domain": {
                "format": "column.names",
                "input": "table"
            },
            "format": "text",
            "id": "ind_variable",
            "name": "ind_variable",
            "type": "string"
        },
        {
            "description": "Column name for dependent variable",
            "domain": {
                "format": "column.names",
                "input": "table"
            },
            "format": "text",
            "id": "dep_variable",
            "name": "dep_variable",
            "type": "string"
        }
    ],
    "mode": "r",
    "name": "picCorrelation",
    "outputs": [
        {
            "description": "Results of PIC regression",
            "format": "r.dataframe",
            "id": "tableResults",
            "name": "tableResults",
            "type": "table"
        }
    ],
    "script": "# get x and y data with names\n\nx <- table[,ind_variable]\nnames(x) <- rownames(table)\ny <- table[,dep_variable]\nnames(y) <- rownames(table)\n\n# calculate independent contrasts\n\npicX <- pic(x, tree)\npicY <- pic(y, tree)\n\n# run regression forced through the origin\n\nres <- lm(picY~picX-1)\noutput <- anova(res)\n\n\n# coerce into table\ntableResults<-as.matrix(cbind(output[,1:5]))\n# tableResults are the final results"
}
