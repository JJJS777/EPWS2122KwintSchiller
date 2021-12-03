/* will help us format the results and calculate the offset for pagination */

function getOffset(currentPage = 1, listPerPage) {
    return (currentPage - 1) * [listPerPage];
}

function emptyOrRows(rows) {
    if (!rows) {
        return 'empty!';
    }
    return rows;
}

module.exports = {
    getOffset,
    emptyOrRows
}