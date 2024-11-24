// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_endpoint.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNetworkEndpointCollection on Isar {
  IsarCollection<NetworkEndpoint> get networkEndpoints => this.collection();
}

const NetworkEndpointSchema = CollectionSchema(
  name: r'NetworkEndpoint',
  id: 654488200310036562,
  properties: {
    r'hostname': PropertySchema(
      id: 0,
      name: r'hostname',
      type: IsarType.string,
    ),
    r'ip': PropertySchema(
      id: 1,
      name: r'ip',
      type: IsarType.string,
    )
  },
  estimateSize: _networkEndpointEstimateSize,
  serialize: _networkEndpointSerialize,
  deserialize: _networkEndpointDeserialize,
  deserializeProp: _networkEndpointDeserializeProp,
  idName: r'id',
  indexes: {
    r'ip': IndexSchema(
      id: 7908241743102109407,
      name: r'ip',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ip',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _networkEndpointGetId,
  getLinks: _networkEndpointGetLinks,
  attach: _networkEndpointAttach,
  version: '3.1.8',
);

int _networkEndpointEstimateSize(
  NetworkEndpoint object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.hostname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.ip.length * 3;
  return bytesCount;
}

void _networkEndpointSerialize(
  NetworkEndpoint object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.hostname);
  writer.writeString(offsets[1], object.ip);
}

NetworkEndpoint _networkEndpointDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NetworkEndpoint(
    hostname: reader.readStringOrNull(offsets[0]),
    ip: reader.readStringOrNull(offsets[1]) ?? "",
  );
  object.id = id;
  return object;
}

P _networkEndpointDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _networkEndpointGetId(NetworkEndpoint object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _networkEndpointGetLinks(NetworkEndpoint object) {
  return [];
}

void _networkEndpointAttach(
    IsarCollection<dynamic> col, Id id, NetworkEndpoint object) {
  object.id = id;
}

extension NetworkEndpointByIndex on IsarCollection<NetworkEndpoint> {
  Future<NetworkEndpoint?> getByIp(String ip) {
    return getByIndex(r'ip', [ip]);
  }

  NetworkEndpoint? getByIpSync(String ip) {
    return getByIndexSync(r'ip', [ip]);
  }

  Future<bool> deleteByIp(String ip) {
    return deleteByIndex(r'ip', [ip]);
  }

  bool deleteByIpSync(String ip) {
    return deleteByIndexSync(r'ip', [ip]);
  }

  Future<List<NetworkEndpoint?>> getAllByIp(List<String> ipValues) {
    final values = ipValues.map((e) => [e]).toList();
    return getAllByIndex(r'ip', values);
  }

  List<NetworkEndpoint?> getAllByIpSync(List<String> ipValues) {
    final values = ipValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'ip', values);
  }

  Future<int> deleteAllByIp(List<String> ipValues) {
    final values = ipValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'ip', values);
  }

  int deleteAllByIpSync(List<String> ipValues) {
    final values = ipValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'ip', values);
  }

  Future<Id> putByIp(NetworkEndpoint object) {
    return putByIndex(r'ip', object);
  }

  Id putByIpSync(NetworkEndpoint object, {bool saveLinks = true}) {
    return putByIndexSync(r'ip', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByIp(List<NetworkEndpoint> objects) {
    return putAllByIndex(r'ip', objects);
  }

  List<Id> putAllByIpSync(List<NetworkEndpoint> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'ip', objects, saveLinks: saveLinks);
  }
}

extension NetworkEndpointQueryWhereSort
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QWhere> {
  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NetworkEndpointQueryWhere
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QWhereClause> {
  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhereClause> ipEqualTo(
      String ip) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ip',
        value: [ip],
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterWhereClause>
      ipNotEqualTo(String ip) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [],
              upper: [ip],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [ip],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [ip],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ip',
              lower: [],
              upper: [ip],
              includeUpper: false,
            ));
      }
    });
  }
}

extension NetworkEndpointQueryFilter
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QFilterCondition> {
  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hostname',
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hostname',
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hostname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hostname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hostname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hostname',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      hostnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hostname',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ip',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ip',
        value: '',
      ));
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterFilterCondition>
      ipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ip',
        value: '',
      ));
    });
  }
}

extension NetworkEndpointQueryObject
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QFilterCondition> {}

extension NetworkEndpointQueryLinks
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QFilterCondition> {}

extension NetworkEndpointQuerySortBy
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QSortBy> {
  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy>
      sortByHostname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.asc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy>
      sortByHostnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.desc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy> sortByIp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.asc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy> sortByIpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.desc);
    });
  }
}

extension NetworkEndpointQuerySortThenBy
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QSortThenBy> {
  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy>
      thenByHostname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.asc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy>
      thenByHostnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hostname', Sort.desc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy> thenByIp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.asc);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QAfterSortBy> thenByIpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ip', Sort.desc);
    });
  }
}

extension NetworkEndpointQueryWhereDistinct
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QDistinct> {
  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QDistinct> distinctByHostname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hostname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NetworkEndpoint, NetworkEndpoint, QDistinct> distinctByIp(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ip', caseSensitive: caseSensitive);
    });
  }
}

extension NetworkEndpointQueryProperty
    on QueryBuilder<NetworkEndpoint, NetworkEndpoint, QQueryProperty> {
  QueryBuilder<NetworkEndpoint, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NetworkEndpoint, String?, QQueryOperations> hostnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hostname');
    });
  }

  QueryBuilder<NetworkEndpoint, String, QQueryOperations> ipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ip');
    });
  }
}
