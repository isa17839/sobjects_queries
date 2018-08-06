/**
 * SO
 *
 * --- Changelog
 *
 * v1.0 Igor Savchenko 2018-07-12
 *
 * @version 1.0
 */
public class SO {

    public static SObject[] getList(String SObjectName, String[] fieldsNames, List<Clause> whereClauses) {
        String query = 'SELECT ' + String.join(fieldsNames, ', ') + ' FROM ' + SObjectName + ' ';
        query += getWhereClause(SObjectName, whereClauses);
        System.debug('query: ' + query);
        return Database.query(query);
    }

    public static Map<String, SObject> getMap(String SObjectName, String[] fieldsNames, List<Clause> whereClauses, String mapField) {
        String query = 'SELECT ' + String.join(fieldsNames, ', ') + ' FROM ' + SObjectName + ' ';
        query += getWhereClause(SObjectName, whereClauses);

        SObject[] sobjects = Database.query(query);
        Map<String, SObject> result = new Map<String, SObject>();
        for (SObject sobj: sobjects) {
            result.put((String)sobj.get(mapField), sobj);
        }
        return result;
    }

    public static Schema.DisplayType getFieldType(String sObjectName, String fieldName) {
        Schema.SObjectType t = Schema.getGlobalDescribe().get(sObjectName);
        Schema.DescribeSObjectResult r = t.getDescribe();
        Schema.DescribeFieldResult f = r.fields.getMap().get(fieldName).getDescribe();
        return f.getType();
    }

    public static String[] getField(SObject[] sobjects, String field, Clause clause) {
        String[] fields = new String[]{};
        for (SObject o: sobjects) {
            if (clause.function == 'notBlank') {
                if (!String.isBlank((String)o.get(field))) {
                    fields.add((String)o.get(field));
                }
            } else {
                fields.add((String)o.get(field));
            }
        }
        return fields;
    }

    public static SObject[] setField(SObject[] sobjects, String field, String value) {
        for (SObject o: sobjects) {
            o.put(field, value);
        }
        return sobjects;
    }

    static String getWhereClause(String SObjectName, List<Clause> whereClauses) {
        String whereClausesString = '';
        if (!whereClauses.isEmpty()) {
            whereClausesString += 'WHERE ';
            String[] whereClausesPeaces = new String[]{};
            for (Clause whereClause: whereClauses) {
                if (whereClause.type == '=') {
                    if (getFieldType(SObjectName, whereClause.field) == Schema.DisplayType.BOOLEAN) {
                        whereClausesPeaces.add(String.escapeSingleQuotes(whereClause.field) + ' = ' + String.escapeSingleQuotes(whereClause.value));
                    } else {
                        whereClausesPeaces.add(String.escapeSingleQuotes(whereClause.field) + ' = \'' + String.escapeSingleQuotes(whereClause.value) + '\'');
                    }
                }
                if (whereClause.type == 'IN') {
                    for (String v: whereClause.values) {
                        v = String.escapeSingleQuotes(v);
                    }
                    String valuesStr = '(\'' + String.join(whereClause.values, '\',\'') + '\')';
                    if (whereClause.values.size() == 0) {
                        whereClausesPeaces.add(String.escapeSingleQuotes(whereClause.field) + ' IN ' + valuesStr + ' AND Id = \'0016E00000ZHb5e\' AND Id = \'0016E00000ZHb5f\' ');
                    } else {
                        whereClausesPeaces.add(String.escapeSingleQuotes(whereClause.field) + ' IN ' + valuesStr + ' ');
                    }
                }
            }
            whereClausesString += String.join(whereClausesPeaces, ' AND ');
        }
        return whereClausesString;
    }

    public class Clause {
        String field = '';
        String value = '';
        String[] values;
        String type = '=';
        String function = '';

        public Clause(String field, String value, String type) {
            this.field = field;
            this.value = value;
            this.type = type;
        }

        public Clause(String field, String[] values, String type) {
            this.field = field;
            this.values = values;
            this.type = type;
        }

        public Clause(String field, String value) {
            this.field = field;
            this.value = value;
        }

        /**
        * List of possible functions: notBlank
        */
        public Clause(String function) {
            this.function = function;
        }

    }

}