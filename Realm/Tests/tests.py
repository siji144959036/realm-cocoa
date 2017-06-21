import re

types = [
  ['unmanaged', 'boolObj', ['@NO', '@YES'], ['r', 'nominmax', 'nosum', 'noavg', 'unman']],
  ['unmanaged', 'intObj', ['@2', '@3'], ['r', 'minmax', 'sum', 'avg', 'unman']],
  ['unmanaged', 'floatObj', ['@2.2f', '@3.3f'], ['r', 'minmax', 'sum', 'avg', 'unman']],
  ['unmanaged', 'doubleObj', ['@2.2', '@3.3'], ['r', 'minmax', 'sum', 'avg', 'unman']],
  ['unmanaged', 'stringObj', ['@"a"', '@"b"'], ['r', 'nominmax', 'nosum', 'noavg', 'unman']],
  ['unmanaged', 'dataObj', ['data(1)', 'data(2)'], ['r', 'nominmax', 'nosum', 'noavg', 'unman']],
  ['unmanaged', 'dateObj', ['date(1)', 'date(2)'], ['r', 'minmax', 'nosum', 'noavg', 'unman']],
  ['optUnmanaged', 'boolObj', ['@NO', '@YES', 'NSNull.null'], ['o', 'nominmax', 'nosum', 'noavg', 'unman']],
  ['optUnmanaged', 'intObj', ['@2', '@3', 'NSNull.null'], ['o', 'minmax', 'sum', 'avg', 'unman']],
  ['optUnmanaged', 'floatObj', ['@2.2f', '@3.3f', 'NSNull.null'], ['o', 'minmax', 'sum', 'avg', 'unman']],
  ['optUnmanaged', 'doubleObj', ['@2.2', '@3.3', 'NSNull.null'], ['o', 'minmax', 'sum', 'avg', 'unman']],
  ['optUnmanaged', 'stringObj', ['@"a"', '@"b"', 'NSNull.null'], ['o', 'nominmax', 'nosum', 'noavg', 'unman']],
  ['optUnmanaged', 'dataObj', ['data(1)', 'data(2)', 'NSNull.null'], ['o', 'nominmax', 'nosum', 'noavg', 'unman']],
  ['optUnmanaged', 'dateObj', ['date(1)', 'date(2)', 'NSNull.null'], ['o', 'minmax', 'nosum', 'noavg', 'unman']],
  ['managed', 'boolObj', ['@NO', '@YES'], ['r', 'nominmax', 'nosum', 'noavg', 'man']],
  ['managed', 'intObj', ['@2', '@3'], ['r', 'minmax', 'sum', 'avg', 'man']],
  ['managed', 'floatObj', ['@2.2f', '@3.3f'], ['r', 'minmax', 'sum', 'avg', 'man']],
  ['managed', 'doubleObj', ['@2.2', '@3.3'], ['r', 'minmax', 'sum', 'avg', 'man']],
  ['managed', 'stringObj', ['@"a"', '@"b"'], ['r', 'nominmax', 'nosum', 'noavg', 'man']],
  ['managed', 'dataObj', ['data(1)', 'data(2)'], ['r', 'nominmax', 'nosum', 'noavg', 'man']],
  ['managed', 'dateObj', ['date(1)', 'date(2)'], ['r', 'minmax', 'nosum', 'noavg', 'man']],
  ['optManaged', 'boolObj', ['@NO', '@YES', 'NSNull.null'], ['o', 'nominmax', 'nosum', 'noavg', 'man']],
  ['optManaged', 'intObj', ['@2', '@3', 'NSNull.null'], ['o', 'minmax', 'sum', 'avg', 'man']],
  ['optManaged', 'floatObj', ['@2.2f', '@3.3f', 'NSNull.null'], ['o', 'minmax', 'sum', 'avg', 'man']],
  ['optManaged', 'doubleObj', ['@2.2', '@3.3', 'NSNull.null'], ['o', 'minmax', 'sum', 'avg', 'man']],
  ['optManaged', 'stringObj', ['@"a"', '@"b"', 'NSNull.null'], ['o', 'nominmax', 'nosum', 'noavg', 'man']],
  ['optManaged', 'dataObj', ['data(1)', 'data(2)', 'NSNull.null'], ['o', 'nominmax', 'nosum', 'noavg', 'man']],
  ['optManaged', 'dateObj', ['date(1)', 'date(2)', 'NSNull.null'], ['o', 'minmax', 'nosum', 'noavg', 'man']],
]
types = [{'obj': t[0], 'prop': t[1], 'v0': t[2][0], 'v1': t[2][1],
          'array': t[0] + '.' + t[1],
          'values': '@[' + ', '.join(t[2]) + ']',
          'first': t[2][0], 'last': t[2][2] if len(t[2]) == 3 else t[2][1],
          's0': t[2][0][1:], 's1': t[2][1][1:],
          'wrong': '@"a"', 'wdesc': 'a', 'wtype': '__NSCFConstantString',
          'type': t[1].replace('Obj', '') + ('?' if 'opt' in t[0] else ''),
          'tags': t[3],
          }
         for t in types]
types[4]['wrong'] = '@2'
types[4]['wdesc'] = '2'
types[4]['wtype'] = '__NSCFNumber'
types[11]['wrong'] = '@2'
types[11]['wdesc'] = '2'
types[11]['wtype'] = '__NSCFNumber'
types[18]['wrong'] = '@2'
types[18]['wdesc'] = '2'
types[18]['wtype'] = '__NSCFNumber'
types[25]['wrong'] = '@2'
types[25]['wdesc'] = '2'
types[25]['wtype'] = '__NSCFNumber'

file = open('/src/realm-cocoa/Realm/Tests/tpl.m', 'rt')
for line in file:
    if not '$' in line:
        print line,
        continue

    filtered_types = types

    start = 0
    end = len(types)
    for tag in re.findall(r'\%([a-z]+)', line):
        filtered_types = [t for t in filtered_types if tag in t['tags']]
        line = line.replace('%' + tag + ' ', '')

    line = line.replace(' ^nl ', '\n    ')
    line = line.replace(' ^n', '\n' + ' ' * line.find('('))

    for t in filtered_types:
        l = line
        for k, v in t.iteritems():
            if k in l:
                l = l.replace('$' + k, v)
        print l,
