/**
 * Q (Query)
 *
 * Eases work with SOQL queries and makes it more flexible
 *
 * @version 1.0
 */
public class Q {

    private String objectName;
    private String fields;
    private String[] whereClauses = new String[]{};
    private Integer lmt;
    private String order;

    public static Q sel(String fields) {
        Q query = new Q();
        query.fields = String.escapeSingleQuotes(fields);
        return query;
    }

    public Q frm(String objectName) {
        this.objectName = String.escapeSingleQuotes(objectName);
        return this;
    }
    
    public Q whr(String whereClause) {
        this.whereClauses.add('(' + whereClause + ')');
        return this;
    }

    public Q whr(String field, String value) {
        this.whereClauses.add('(' + String.escapeSingleQuotes(U.ifNull(field, '')) + ' = \''+ String.escapeSingleQuotes(U.ifNull(value, '')) +'\'' + ')');
        return this;
    }

    /**
     * Handle 'IN' statement
     */
    public Q whr(String field, String[] values) {
        // in this case we expect to get no resuls
        if (values.size() == 0) {
            this.whereClauses.add('(Id = null)');
            return this;
        }

        for (String v: values) {
            v = String.escapeSingleQuotes(U.ifNull(v, ''));
        }

        String valuesStr = '(\'' + String.join(values, '\',\'') + '\')';
        this.whereClauses.add('(' + String.escapeSingleQuotes(field) + ' IN ' + valuesStr + ')');
        return this;
    }

    public Q whr(String field, Set<String> values) {
        String[] listValues = new String[]{};
        listValues.addAll(values);
        return whr(field, new List<String>(values));
    }

    public Q whr(String field, Set<Id> values) {
        return whr(field, (List<String>) new List<Id>(values));
    }

    public Q lmt(Integer maxLimit) {
        this.lmt = maxLimit;
        return this;
    }

    public Q order(String order) {
        this.order = order;
        return this;
    }

    public SObject[] query() {
        String queryString = 'SELECT ' + fields + ' FROM ' + objectName;
        if (!whereClauses.isEmpty()) {
            queryString += ' WHERE ' + String.join(whereClauses, ' AND ');
        }

        queryString += order != null ? ' ORDER BY ' + String.escapeSingleQuotes(order) : '';
        queryString += lmt != null ? ' LIMIT ' + String.valueOf(lmt) : '';

        return Database.query(queryString);
    }

    public SObject queryFirst() {
        lmt = 1;
        SObject[] results = query();

        // if no result - we create new empty object and return it to avoid null pointer exceptions
        return results.isEmpty() ? Schema.getGlobalDescribe().get(objectName).newSObject() : results[0];
    }

}