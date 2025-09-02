import 'package:avk/router/path_exporter.dart';


/// report view contains all the report related data's
class ReportView extends StatefulWidget {

  /// constructors
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  /// nested data
  final Map<String, dynamic> nestedData =   <String, dynamic>{
    'zones': <Map<String, Object>>[
      <String, Object>{
        'level': 'level 1',
        'name': 'Erode',
        'childrens': <Map<String, Object>>[
          <String, Object>{
            'level': 'level 2',
            'name': 'Perundurai',
            'childrens': <Map<String, Object>>[
              <String, Object>{
                'level': 'level 3',
                'name': 'Vengamedu',
                'childrens': <Map<String, Object>>[
                  <String, Object>{
                    'level': 'level 4',
                    'name': 'North Street',
                    'childrens': <Map<String, String>>[
                      <String, String>{'level': 'level 5', 'name': 'Old Colony'},
                      <String, String>{'level': 'level 5', 'name': 'New Colony'},
                    ],
                  },
                  <String, Object>{
                    'level': 'level 4',
                    'name': 'South Street',
                    'childrens': <Map<String, String>>[
                      <String, String>{'level': 'level 5', 'name': 'East End'},
                      <String, String>{'level': 'level 5', 'name': 'West End'},
                    ],
                  },
                ],
              },
              <String, Object>{
                'level': 'level 3',
                'name': 'Sipcot',
                'childrens': <Map<String, Object>>[
                  <String, Object>{
                    'level': 'level 4',
                    'name': 'Industrial Area 1',
                    'childrens': <Map<String, String>>[
                      <String, String>{'level': 'level 5', 'name': 'Phase 1'},
                      <String, String>{'level': 'level 5', 'name': 'Phase 2'},
                    ],
                  },
                  <String, Object>{
                    'level': 'level 4',
                    'name': 'Industrial Area 2',
                    'childrens': <Map<String, String>>[
                      <String, String>{'level': 'level 5', 'name': 'Block A'},
                      <String, String>{'level': 'level 5', 'name': 'Block B'},
                    ],
                  },
                ],
              },
            ],
          },
        ],
      },
      <String, Object>{
        'level': 'level 1',
        'name': 'Salem',
        'childrens': <Map<String, Object>>[
          <String, Object>{
            'level': 'level 2',
            'name': 'Attur',
            'childrens': <Map<String, Object>>[
              <String, Object>{
                'level': 'level 3',
                'name': 'Town Center',
                'childrens': <Map<String, Object>>[
                  <String, Object>{
                    'level': 'level 4',
                    'name': 'Main Road',
                    'childrens': <Map<String, String>>[
                      <String, String>{'level': 'level 5', 'name': 'Shop Street'},
                      <String, String>{'level': 'level 5', 'name': 'Temple Street'},
                    ],
                  },
                ],
              },
            ],
          },
          <String, Object>{
            'level': 'level 2',
            'name': 'Omalur',
            'childrens': <Map<String, Object>>[
              <String, Object>{
                'level': 'level 3',
                'name': 'Market Area',
                'childrens': <Map<String, Object>>[
                  <String, Object>{
                    'level': 'level 4',
                    'name': 'Fruit Market',
                    'childrens': <Map<String, String>>[
                      <String, String>{'level': 'level 5', 'name': 'North Wing'},
                      <String, String>{'level': 'level 5', 'name': 'South Wing'},
                      <String, String>{'level': 'level 5', 'name': 'West Wing'},
                      <String, String>{'level': 'level 5', 'name': 'East Wing'},
                    ],
                  },
                ],
              },
            ],
          },
        ],
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<List<String?>> flatData = <List<String?>>[];
    _flatten(nestedData['zones'], <String?>[], flatData);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // horizontal scroll
      physics:const ClampingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.sizeOf(context).width, // ensures min width
        ),
        child: SingleChildScrollView(
          child: Table(
            border: const TableBorder(
              top: BorderSide(color: Color(0xFFCCCCCC)),
              bottom: BorderSide(color: Color(0xFFCCCCCC)),
              left: BorderSide(color: Color(0xFFCCCCCC)),
              right: BorderSide(color: Color(0xFFCCCCCC)),
              verticalInside: BorderSide(color: Color(0xFFCCCCCC)),
            ),
            defaultColumnWidth: const FixedColumnWidth(
              200,
            ), // fixed width for horizontal scroll
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[_buildHeader(), ..._buildMergedRows(flatData)],
          ),
        ),
      ),
    );
  }

  TableRow _buildHeader() {
    return const TableRow(
      decoration: BoxDecoration(color: Color(0xffe0e6f8)),
      children: <Widget>[
        _HeaderCell('SL. No'),
        _HeaderCell('Level 1'),
        _HeaderCell('Level 2'),
        _HeaderCell('Level 3'),
        _HeaderCell('Level 4'),
        _HeaderCell('Level 5'),
      ],
    );
  }

  List<TableRow> _buildMergedRows(List<List<String?>> data) {
    final List<TableRow> rows = <TableRow>[];

    // Calculate spans
    final List<List<int>> spans = List<List<int>>.generate(
      data.length,
          (_) => List<int>.filled(data[0].length, 0),
    );
    for (int c = 0; c < data[0].length; c++) {
      int r = 0;
      while (r < data.length) {
        int spanCount = 1;
        for (int rr = r + 1; rr < data.length; rr++) {
          if (data[rr][c] == data[r][c] && data[r][c] != null) {
            spanCount++;
          } else {
            break;
          }
        }
        for (int i = 0; i < spanCount; i++) {
          spans[r + i][c] = spanCount;
        }
        r += spanCount;
      }
    }

    int slNoCounter = 1;

    for (int r = 0; r < data.length; r++) {
      final List<Widget> cells = <Widget>[];

      // SL.No column
      final int level1Span = spans[r][0];
      int startRow = r;
      while (startRow > 0 &&
          data[startRow - 1][0] == data[r][0] &&
          data[r][0] != null) {
        startRow--;
      }
      int middleRow = startRow + (level1Span ~/ 2);

      // Add top border if it's the first row of a group
      bool addTopSL = r > 0 && data[r][0] != data[r - 1][0];

      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              // color: Colors.blueGrey,
              border: Border(
                top:
                addTopSL
                    ? const BorderSide(color: Color(0xFFCCCCCC))
                    : BorderSide.none,
              ),
            ),
            alignment: Alignment.center,
            child:
            r == middleRow ? Text('$slNoCounter') : const SizedBox.shrink(),
          ),
        ),
      );

      // Other columns
      for (int c = 0; c < data[r].length; c++) {
        final int spanCount = spans[r][c];
        if (spanCount == 0) {
          cells.add(const SizedBox.shrink());
        } else {
          int startRow2 = r;
          while (startRow2 > 0 &&
              data[startRow2 - 1][c] == data[r][c] &&
              data[r][c] != null) {
            startRow2--;
          }
          int middleRow2 = startRow2 + (spanCount ~/ 2);

          bool addTop = r > 0 && data[r][c] != data[r - 1][c];

          cells.add(
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                height: 40,
                // padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // color: Colors.blue.withValues(alpha: 0.2),
                  border: Border(
                    top:
                    addTop
                        ? const BorderSide(
                      color: Color(0xFFCCCCCC),
                    )
                        : BorderSide.none,
                  ),
                ),
                alignment: Alignment.center,
                child:
                r == middleRow2
                    ? Text(
                  data[r][c] ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                )
                    : const SizedBox.shrink(),
              ),
            ),
          );
        }
      }

      rows.add(TableRow(children: cells));

      if (r == middleRow) {
        slNoCounter++;
      }
    }

    return rows;
  }

  void _flatten(
      List<dynamic>? nodes,
      List<String?> path,
      List<List<String?>> out,
      ) {
    if (nodes == null || nodes.isEmpty) {
      return;
    }
    for (var node in nodes) {
      List<String?> newPath = List<String?>.from(path)..add(node['name']);
      if (node['childrens'] == null || node['childrens'].isEmpty) {
        while (newPath.length < 5) {
          newPath.add(null);
        }
        out.add(newPath);
      } else {
        _flatten(node['childrens'], newPath, out);
      }
    }
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
