// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: hqyIECPara.proto

#ifndef PROTOBUF_hqyIECPara_2eproto__INCLUDED
#define PROTOBUF_hqyIECPara_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 3002000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 3002000 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/metadata.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/generated_enum_reflection.h>
#include <google/protobuf/unknown_field_set.h>
#include "hqyIECBaseSetting.pb.h"
#include "hqyIec6185092.pb.h"
#include "hqyiec6185091.pb.h"
#include "hqyiec6004478.pb.h"
#include "hqyiecCollector.pb.h"
#include "hqyGoosePublish.pb.h"
#include "hqyGooseSubscribe.pb.h"
// @@protoc_insertion_point(includes)
namespace hqyGoose_Pub_Setting {
class Control_Block;
class Control_BlockDefaultTypeInternal;
extern Control_BlockDefaultTypeInternal _Control_Block_default_instance_;
class Goose_Publish;
class Goose_PublishDefaultTypeInternal;
extern Goose_PublishDefaultTypeInternal _Goose_Publish_default_instance_;
}  // namespace hqyGoose_Pub_Setting
namespace hqyGoose_Sub_Setting {
class Control_Block;
class Control_BlockDefaultTypeInternal;
extern Control_BlockDefaultTypeInternal _Control_Block_default_instance_;
class Goose_Sub;
class Goose_SubDefaultTypeInternal;
extern Goose_SubDefaultTypeInternal _Goose_Sub_default_instance_;
}  // namespace hqyGoose_Sub_Setting
namespace hqyIEC60044_7_8_Setting {
class Channel_Info;
class Channel_InfoDefaultTypeInternal;
extern Channel_InfoDefaultTypeInternal _Channel_Info_default_instance_;
class Control_Block;
class Control_BlockDefaultTypeInternal;
extern Control_BlockDefaultTypeInternal _Control_Block_default_instance_;
class IEC60044_7_8;
class IEC60044_7_8DefaultTypeInternal;
extern IEC60044_7_8DefaultTypeInternal _IEC60044_7_8_default_instance_;
}  // namespace hqyIEC60044_7_8_Setting
namespace hqyIEC61850_9_1_Setting {
class Channel_Info;
class Channel_InfoDefaultTypeInternal;
extern Channel_InfoDefaultTypeInternal _Channel_Info_default_instance_;
class Control_Block;
class Control_BlockDefaultTypeInternal;
extern Control_BlockDefaultTypeInternal _Control_Block_default_instance_;
class IEC61850_9_1;
class IEC61850_9_1DefaultTypeInternal;
extern IEC61850_9_1DefaultTypeInternal _IEC61850_9_1_default_instance_;
}  // namespace hqyIEC61850_9_1_Setting
namespace hqyIEC61850_9_2_Setting {
class Channel_Info;
class Channel_InfoDefaultTypeInternal;
extern Channel_InfoDefaultTypeInternal _Channel_Info_default_instance_;
class Control_Block;
class Control_BlockDefaultTypeInternal;
extern Control_BlockDefaultTypeInternal _Control_Block_default_instance_;
class FactorInfo;
class FactorInfoDefaultTypeInternal;
extern FactorInfoDefaultTypeInternal _FactorInfo_default_instance_;
class FactorItem;
class FactorItemDefaultTypeInternal;
extern FactorItemDefaultTypeInternal _FactorItem_default_instance_;
class IEC61850_9_2;
class IEC61850_9_2DefaultTypeInternal;
extern IEC61850_9_2DefaultTypeInternal _IEC61850_9_2_default_instance_;
class IEC61850_9_2LE;
class IEC61850_9_2LEDefaultTypeInternal;
extern IEC61850_9_2LEDefaultTypeInternal _IEC61850_9_2LE_default_instance_;
}  // namespace hqyIEC61850_9_2_Setting
namespace hqyIECBaseSetting {
class BaseSetting;
class BaseSettingDefaultTypeInternal;
extern BaseSettingDefaultTypeInternal _BaseSetting_default_instance_;
class Ratio;
class RatioDefaultTypeInternal;
extern RatioDefaultTypeInternal _Ratio_default_instance_;
}  // namespace hqyIECBaseSetting
namespace hqyIECCollector_Setting {
class Channel_Info;
class Channel_InfoDefaultTypeInternal;
extern Channel_InfoDefaultTypeInternal _Channel_Info_default_instance_;
class Control_Block;
class Control_BlockDefaultTypeInternal;
extern Control_BlockDefaultTypeInternal _Control_Block_default_instance_;
class IECCollector;
class IECCollectorDefaultTypeInternal;
extern IECCollectorDefaultTypeInternal _IECCollector_default_instance_;
}  // namespace hqyIECCollector_Setting
namespace hqyIECPara {
class IECPara;
class IECParaDefaultTypeInternal;
extern IECParaDefaultTypeInternal _IECPara_default_instance_;
}  // namespace hqyIECPara

namespace hqyIECPara {

namespace protobuf_hqyIECPara_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_hqyIECPara_2eproto

enum digitalactype {
  digitalactype_smv9_1 = 0,
  digitalactype_smv9_2 = 1,
  digitalactype_ft3 = 2,
  digitalactype_ft3ex = 3,
  digitalactype_stategrid = 4,
  digitalactype_xinning = 5,
  digitalactype_xuji = 6,
  digitalactype_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  digitalactype_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool digitalactype_IsValid(int value);
const digitalactype digitalactype_MIN = digitalactype_smv9_1;
const digitalactype digitalactype_MAX = digitalactype_xuji;
const int digitalactype_ARRAYSIZE = digitalactype_MAX + 1;

const ::google::protobuf::EnumDescriptor* digitalactype_descriptor();
inline const ::std::string& digitalactype_Name(digitalactype value) {
  return ::google::protobuf::internal::NameOfEnum(
    digitalactype_descriptor(), value);
}
inline bool digitalactype_Parse(
    const ::std::string& name, digitalactype* value) {
  return ::google::protobuf::internal::ParseNamedEnum<digitalactype>(
    digitalactype_descriptor(), name, value);
}
// ===================================================================

class IECPara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:hqyIECPara.IECPara) */ {
 public:
  IECPara();
  virtual ~IECPara();

  IECPara(const IECPara& from);

  inline IECPara& operator=(const IECPara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const IECPara& default_instance();

  static inline const IECPara* internal_default_instance() {
    return reinterpret_cast<const IECPara*>(
               &_IECPara_default_instance_);
  }

  void Swap(IECPara* other);

  // implements Message ----------------------------------------------

  inline IECPara* New() const PROTOBUF_FINAL { return New(NULL); }

  IECPara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const IECPara& from);
  void MergeFrom(const IECPara& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* SerializeWithCachedSizesToArray(::google::protobuf::uint8* output)
      const PROTOBUF_FINAL {
    return InternalSerializeWithCachedSizesToArray(
        ::google::protobuf::io::CodedOutputStream::IsDefaultSerializationDeterministic(), output);
  }
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(IECPara* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // .hqyIECBaseSetting.BaseSetting obasesetting = 1;
  bool has_obasesetting() const;
  void clear_obasesetting();
  static const int kObasesettingFieldNumber = 1;
  const ::hqyIECBaseSetting::BaseSetting& obasesetting() const;
  ::hqyIECBaseSetting::BaseSetting* mutable_obasesetting();
  ::hqyIECBaseSetting::BaseSetting* release_obasesetting();
  void set_allocated_obasesetting(::hqyIECBaseSetting::BaseSetting* obasesetting);

  // .hqyIEC61850_9_2_Setting.IEC61850_9_2 osmv = 2;
  bool has_osmv() const;
  void clear_osmv();
  static const int kOsmvFieldNumber = 2;
  const ::hqyIEC61850_9_2_Setting::IEC61850_9_2& osmv() const;
  ::hqyIEC61850_9_2_Setting::IEC61850_9_2* mutable_osmv();
  ::hqyIEC61850_9_2_Setting::IEC61850_9_2* release_osmv();
  void set_allocated_osmv(::hqyIEC61850_9_2_Setting::IEC61850_9_2* osmv);

  // .hqyIEC61850_9_1_Setting.IEC61850_9_1 osmv_91 = 3;
  bool has_osmv_91() const;
  void clear_osmv_91();
  static const int kOsmv91FieldNumber = 3;
  const ::hqyIEC61850_9_1_Setting::IEC61850_9_1& osmv_91() const;
  ::hqyIEC61850_9_1_Setting::IEC61850_9_1* mutable_osmv_91();
  ::hqyIEC61850_9_1_Setting::IEC61850_9_1* release_osmv_91();
  void set_allocated_osmv_91(::hqyIEC61850_9_1_Setting::IEC61850_9_1* osmv_91);

  // .hqyIEC60044_7_8_Setting.IEC60044_7_8 osmv_Ft3StateGrid = 4;
  bool has_osmv_ft3stategrid() const;
  void clear_osmv_ft3stategrid();
  static const int kOsmvFt3StateGridFieldNumber = 4;
  const ::hqyIEC60044_7_8_Setting::IEC60044_7_8& osmv_ft3stategrid() const;
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* mutable_osmv_ft3stategrid();
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* release_osmv_ft3stategrid();
  void set_allocated_osmv_ft3stategrid(::hqyIEC60044_7_8_Setting::IEC60044_7_8* osmv_ft3stategrid);

  // .hqyIEC60044_7_8_Setting.IEC60044_7_8 osmv_Ft3NR = 5;
  bool has_osmv_ft3nr() const;
  void clear_osmv_ft3nr();
  static const int kOsmvFt3NRFieldNumber = 5;
  const ::hqyIEC60044_7_8_Setting::IEC60044_7_8& osmv_ft3nr() const;
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* mutable_osmv_ft3nr();
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* release_osmv_ft3nr();
  void set_allocated_osmv_ft3nr(::hqyIEC60044_7_8_Setting::IEC60044_7_8* osmv_ft3nr);

  // .hqyIECCollector_Setting.IECCollector ocollector_StateGrid = 6;
  bool has_ocollector_stategrid() const;
  void clear_ocollector_stategrid();
  static const int kOcollectorStateGridFieldNumber = 6;
  const ::hqyIECCollector_Setting::IECCollector& ocollector_stategrid() const;
  ::hqyIECCollector_Setting::IECCollector* mutable_ocollector_stategrid();
  ::hqyIECCollector_Setting::IECCollector* release_ocollector_stategrid();
  void set_allocated_ocollector_stategrid(::hqyIECCollector_Setting::IECCollector* ocollector_stategrid);

  // .hqyIECCollector_Setting.IECCollector ocollector_XinNing = 7;
  bool has_ocollector_xinning() const;
  void clear_ocollector_xinning();
  static const int kOcollectorXinNingFieldNumber = 7;
  const ::hqyIECCollector_Setting::IECCollector& ocollector_xinning() const;
  ::hqyIECCollector_Setting::IECCollector* mutable_ocollector_xinning();
  ::hqyIECCollector_Setting::IECCollector* release_ocollector_xinning();
  void set_allocated_ocollector_xinning(::hqyIECCollector_Setting::IECCollector* ocollector_xinning);

  // .hqyIECCollector_Setting.IECCollector ocollector_XuJi = 8;
  bool has_ocollector_xuji() const;
  void clear_ocollector_xuji();
  static const int kOcollectorXuJiFieldNumber = 8;
  const ::hqyIECCollector_Setting::IECCollector& ocollector_xuji() const;
  ::hqyIECCollector_Setting::IECCollector* mutable_ocollector_xuji();
  ::hqyIECCollector_Setting::IECCollector* release_ocollector_xuji();
  void set_allocated_ocollector_xuji(::hqyIECCollector_Setting::IECCollector* ocollector_xuji);

  // .hqyGoose_Pub_Setting.Goose_Publish ogoosepublish = 10;
  bool has_ogoosepublish() const;
  void clear_ogoosepublish();
  static const int kOgoosepublishFieldNumber = 10;
  const ::hqyGoose_Pub_Setting::Goose_Publish& ogoosepublish() const;
  ::hqyGoose_Pub_Setting::Goose_Publish* mutable_ogoosepublish();
  ::hqyGoose_Pub_Setting::Goose_Publish* release_ogoosepublish();
  void set_allocated_ogoosepublish(::hqyGoose_Pub_Setting::Goose_Publish* ogoosepublish);

  // .hqyGoose_Sub_Setting.Goose_Sub ogoosesub = 11;
  bool has_ogoosesub() const;
  void clear_ogoosesub();
  static const int kOgoosesubFieldNumber = 11;
  const ::hqyGoose_Sub_Setting::Goose_Sub& ogoosesub() const;
  ::hqyGoose_Sub_Setting::Goose_Sub* mutable_ogoosesub();
  ::hqyGoose_Sub_Setting::Goose_Sub* release_ogoosesub();
  void set_allocated_ogoosesub(::hqyGoose_Sub_Setting::Goose_Sub* ogoosesub);

  // .hqyIECPara.digitalactype oactype = 9;
  void clear_oactype();
  static const int kOactypeFieldNumber = 9;
  ::hqyIECPara::digitalactype oactype() const;
  void set_oactype(::hqyIECPara::digitalactype value);

  // @@protoc_insertion_point(class_scope:hqyIECPara.IECPara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::hqyIECBaseSetting::BaseSetting* obasesetting_;
  ::hqyIEC61850_9_2_Setting::IEC61850_9_2* osmv_;
  ::hqyIEC61850_9_1_Setting::IEC61850_9_1* osmv_91_;
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* osmv_ft3stategrid_;
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* osmv_ft3nr_;
  ::hqyIECCollector_Setting::IECCollector* ocollector_stategrid_;
  ::hqyIECCollector_Setting::IECCollector* ocollector_xinning_;
  ::hqyIECCollector_Setting::IECCollector* ocollector_xuji_;
  ::hqyGoose_Pub_Setting::Goose_Publish* ogoosepublish_;
  ::hqyGoose_Sub_Setting::Goose_Sub* ogoosesub_;
  int oactype_;
  mutable int _cached_size_;
  friend struct  protobuf_hqyIECPara_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// IECPara

// .hqyIECBaseSetting.BaseSetting obasesetting = 1;
inline bool IECPara::has_obasesetting() const {
  return this != internal_default_instance() && obasesetting_ != NULL;
}
inline void IECPara::clear_obasesetting() {
  if (GetArenaNoVirtual() == NULL && obasesetting_ != NULL) delete obasesetting_;
  obasesetting_ = NULL;
}
inline const ::hqyIECBaseSetting::BaseSetting& IECPara::obasesetting() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.obasesetting)
  return obasesetting_ != NULL ? *obasesetting_
                         : *::hqyIECBaseSetting::BaseSetting::internal_default_instance();
}
inline ::hqyIECBaseSetting::BaseSetting* IECPara::mutable_obasesetting() {
  
  if (obasesetting_ == NULL) {
    obasesetting_ = new ::hqyIECBaseSetting::BaseSetting;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.obasesetting)
  return obasesetting_;
}
inline ::hqyIECBaseSetting::BaseSetting* IECPara::release_obasesetting() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.obasesetting)
  
  ::hqyIECBaseSetting::BaseSetting* temp = obasesetting_;
  obasesetting_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_obasesetting(::hqyIECBaseSetting::BaseSetting* obasesetting) {
  delete obasesetting_;
  obasesetting_ = obasesetting;
  if (obasesetting) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.obasesetting)
}

// .hqyIEC61850_9_2_Setting.IEC61850_9_2 osmv = 2;
inline bool IECPara::has_osmv() const {
  return this != internal_default_instance() && osmv_ != NULL;
}
inline void IECPara::clear_osmv() {
  if (GetArenaNoVirtual() == NULL && osmv_ != NULL) delete osmv_;
  osmv_ = NULL;
}
inline const ::hqyIEC61850_9_2_Setting::IEC61850_9_2& IECPara::osmv() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.osmv)
  return osmv_ != NULL ? *osmv_
                         : *::hqyIEC61850_9_2_Setting::IEC61850_9_2::internal_default_instance();
}
inline ::hqyIEC61850_9_2_Setting::IEC61850_9_2* IECPara::mutable_osmv() {
  
  if (osmv_ == NULL) {
    osmv_ = new ::hqyIEC61850_9_2_Setting::IEC61850_9_2;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.osmv)
  return osmv_;
}
inline ::hqyIEC61850_9_2_Setting::IEC61850_9_2* IECPara::release_osmv() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.osmv)
  
  ::hqyIEC61850_9_2_Setting::IEC61850_9_2* temp = osmv_;
  osmv_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_osmv(::hqyIEC61850_9_2_Setting::IEC61850_9_2* osmv) {
  delete osmv_;
  osmv_ = osmv;
  if (osmv) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.osmv)
}

// .hqyIEC61850_9_1_Setting.IEC61850_9_1 osmv_91 = 3;
inline bool IECPara::has_osmv_91() const {
  return this != internal_default_instance() && osmv_91_ != NULL;
}
inline void IECPara::clear_osmv_91() {
  if (GetArenaNoVirtual() == NULL && osmv_91_ != NULL) delete osmv_91_;
  osmv_91_ = NULL;
}
inline const ::hqyIEC61850_9_1_Setting::IEC61850_9_1& IECPara::osmv_91() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.osmv_91)
  return osmv_91_ != NULL ? *osmv_91_
                         : *::hqyIEC61850_9_1_Setting::IEC61850_9_1::internal_default_instance();
}
inline ::hqyIEC61850_9_1_Setting::IEC61850_9_1* IECPara::mutable_osmv_91() {
  
  if (osmv_91_ == NULL) {
    osmv_91_ = new ::hqyIEC61850_9_1_Setting::IEC61850_9_1;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.osmv_91)
  return osmv_91_;
}
inline ::hqyIEC61850_9_1_Setting::IEC61850_9_1* IECPara::release_osmv_91() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.osmv_91)
  
  ::hqyIEC61850_9_1_Setting::IEC61850_9_1* temp = osmv_91_;
  osmv_91_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_osmv_91(::hqyIEC61850_9_1_Setting::IEC61850_9_1* osmv_91) {
  delete osmv_91_;
  osmv_91_ = osmv_91;
  if (osmv_91) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.osmv_91)
}

// .hqyIEC60044_7_8_Setting.IEC60044_7_8 osmv_Ft3StateGrid = 4;
inline bool IECPara::has_osmv_ft3stategrid() const {
  return this != internal_default_instance() && osmv_ft3stategrid_ != NULL;
}
inline void IECPara::clear_osmv_ft3stategrid() {
  if (GetArenaNoVirtual() == NULL && osmv_ft3stategrid_ != NULL) delete osmv_ft3stategrid_;
  osmv_ft3stategrid_ = NULL;
}
inline const ::hqyIEC60044_7_8_Setting::IEC60044_7_8& IECPara::osmv_ft3stategrid() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.osmv_Ft3StateGrid)
  return osmv_ft3stategrid_ != NULL ? *osmv_ft3stategrid_
                         : *::hqyIEC60044_7_8_Setting::IEC60044_7_8::internal_default_instance();
}
inline ::hqyIEC60044_7_8_Setting::IEC60044_7_8* IECPara::mutable_osmv_ft3stategrid() {
  
  if (osmv_ft3stategrid_ == NULL) {
    osmv_ft3stategrid_ = new ::hqyIEC60044_7_8_Setting::IEC60044_7_8;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.osmv_Ft3StateGrid)
  return osmv_ft3stategrid_;
}
inline ::hqyIEC60044_7_8_Setting::IEC60044_7_8* IECPara::release_osmv_ft3stategrid() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.osmv_Ft3StateGrid)
  
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* temp = osmv_ft3stategrid_;
  osmv_ft3stategrid_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_osmv_ft3stategrid(::hqyIEC60044_7_8_Setting::IEC60044_7_8* osmv_ft3stategrid) {
  delete osmv_ft3stategrid_;
  osmv_ft3stategrid_ = osmv_ft3stategrid;
  if (osmv_ft3stategrid) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.osmv_Ft3StateGrid)
}

// .hqyIEC60044_7_8_Setting.IEC60044_7_8 osmv_Ft3NR = 5;
inline bool IECPara::has_osmv_ft3nr() const {
  return this != internal_default_instance() && osmv_ft3nr_ != NULL;
}
inline void IECPara::clear_osmv_ft3nr() {
  if (GetArenaNoVirtual() == NULL && osmv_ft3nr_ != NULL) delete osmv_ft3nr_;
  osmv_ft3nr_ = NULL;
}
inline const ::hqyIEC60044_7_8_Setting::IEC60044_7_8& IECPara::osmv_ft3nr() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.osmv_Ft3NR)
  return osmv_ft3nr_ != NULL ? *osmv_ft3nr_
                         : *::hqyIEC60044_7_8_Setting::IEC60044_7_8::internal_default_instance();
}
inline ::hqyIEC60044_7_8_Setting::IEC60044_7_8* IECPara::mutable_osmv_ft3nr() {
  
  if (osmv_ft3nr_ == NULL) {
    osmv_ft3nr_ = new ::hqyIEC60044_7_8_Setting::IEC60044_7_8;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.osmv_Ft3NR)
  return osmv_ft3nr_;
}
inline ::hqyIEC60044_7_8_Setting::IEC60044_7_8* IECPara::release_osmv_ft3nr() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.osmv_Ft3NR)
  
  ::hqyIEC60044_7_8_Setting::IEC60044_7_8* temp = osmv_ft3nr_;
  osmv_ft3nr_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_osmv_ft3nr(::hqyIEC60044_7_8_Setting::IEC60044_7_8* osmv_ft3nr) {
  delete osmv_ft3nr_;
  osmv_ft3nr_ = osmv_ft3nr;
  if (osmv_ft3nr) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.osmv_Ft3NR)
}

// .hqyIECCollector_Setting.IECCollector ocollector_StateGrid = 6;
inline bool IECPara::has_ocollector_stategrid() const {
  return this != internal_default_instance() && ocollector_stategrid_ != NULL;
}
inline void IECPara::clear_ocollector_stategrid() {
  if (GetArenaNoVirtual() == NULL && ocollector_stategrid_ != NULL) delete ocollector_stategrid_;
  ocollector_stategrid_ = NULL;
}
inline const ::hqyIECCollector_Setting::IECCollector& IECPara::ocollector_stategrid() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.ocollector_StateGrid)
  return ocollector_stategrid_ != NULL ? *ocollector_stategrid_
                         : *::hqyIECCollector_Setting::IECCollector::internal_default_instance();
}
inline ::hqyIECCollector_Setting::IECCollector* IECPara::mutable_ocollector_stategrid() {
  
  if (ocollector_stategrid_ == NULL) {
    ocollector_stategrid_ = new ::hqyIECCollector_Setting::IECCollector;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.ocollector_StateGrid)
  return ocollector_stategrid_;
}
inline ::hqyIECCollector_Setting::IECCollector* IECPara::release_ocollector_stategrid() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.ocollector_StateGrid)
  
  ::hqyIECCollector_Setting::IECCollector* temp = ocollector_stategrid_;
  ocollector_stategrid_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_ocollector_stategrid(::hqyIECCollector_Setting::IECCollector* ocollector_stategrid) {
  delete ocollector_stategrid_;
  ocollector_stategrid_ = ocollector_stategrid;
  if (ocollector_stategrid) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.ocollector_StateGrid)
}

// .hqyIECCollector_Setting.IECCollector ocollector_XinNing = 7;
inline bool IECPara::has_ocollector_xinning() const {
  return this != internal_default_instance() && ocollector_xinning_ != NULL;
}
inline void IECPara::clear_ocollector_xinning() {
  if (GetArenaNoVirtual() == NULL && ocollector_xinning_ != NULL) delete ocollector_xinning_;
  ocollector_xinning_ = NULL;
}
inline const ::hqyIECCollector_Setting::IECCollector& IECPara::ocollector_xinning() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.ocollector_XinNing)
  return ocollector_xinning_ != NULL ? *ocollector_xinning_
                         : *::hqyIECCollector_Setting::IECCollector::internal_default_instance();
}
inline ::hqyIECCollector_Setting::IECCollector* IECPara::mutable_ocollector_xinning() {
  
  if (ocollector_xinning_ == NULL) {
    ocollector_xinning_ = new ::hqyIECCollector_Setting::IECCollector;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.ocollector_XinNing)
  return ocollector_xinning_;
}
inline ::hqyIECCollector_Setting::IECCollector* IECPara::release_ocollector_xinning() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.ocollector_XinNing)
  
  ::hqyIECCollector_Setting::IECCollector* temp = ocollector_xinning_;
  ocollector_xinning_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_ocollector_xinning(::hqyIECCollector_Setting::IECCollector* ocollector_xinning) {
  delete ocollector_xinning_;
  ocollector_xinning_ = ocollector_xinning;
  if (ocollector_xinning) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.ocollector_XinNing)
}

// .hqyIECCollector_Setting.IECCollector ocollector_XuJi = 8;
inline bool IECPara::has_ocollector_xuji() const {
  return this != internal_default_instance() && ocollector_xuji_ != NULL;
}
inline void IECPara::clear_ocollector_xuji() {
  if (GetArenaNoVirtual() == NULL && ocollector_xuji_ != NULL) delete ocollector_xuji_;
  ocollector_xuji_ = NULL;
}
inline const ::hqyIECCollector_Setting::IECCollector& IECPara::ocollector_xuji() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.ocollector_XuJi)
  return ocollector_xuji_ != NULL ? *ocollector_xuji_
                         : *::hqyIECCollector_Setting::IECCollector::internal_default_instance();
}
inline ::hqyIECCollector_Setting::IECCollector* IECPara::mutable_ocollector_xuji() {
  
  if (ocollector_xuji_ == NULL) {
    ocollector_xuji_ = new ::hqyIECCollector_Setting::IECCollector;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.ocollector_XuJi)
  return ocollector_xuji_;
}
inline ::hqyIECCollector_Setting::IECCollector* IECPara::release_ocollector_xuji() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.ocollector_XuJi)
  
  ::hqyIECCollector_Setting::IECCollector* temp = ocollector_xuji_;
  ocollector_xuji_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_ocollector_xuji(::hqyIECCollector_Setting::IECCollector* ocollector_xuji) {
  delete ocollector_xuji_;
  ocollector_xuji_ = ocollector_xuji;
  if (ocollector_xuji) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.ocollector_XuJi)
}

// .hqyIECPara.digitalactype oactype = 9;
inline void IECPara::clear_oactype() {
  oactype_ = 0;
}
inline ::hqyIECPara::digitalactype IECPara::oactype() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.oactype)
  return static_cast< ::hqyIECPara::digitalactype >(oactype_);
}
inline void IECPara::set_oactype(::hqyIECPara::digitalactype value) {
  
  oactype_ = value;
  // @@protoc_insertion_point(field_set:hqyIECPara.IECPara.oactype)
}

// .hqyGoose_Pub_Setting.Goose_Publish ogoosepublish = 10;
inline bool IECPara::has_ogoosepublish() const {
  return this != internal_default_instance() && ogoosepublish_ != NULL;
}
inline void IECPara::clear_ogoosepublish() {
  if (GetArenaNoVirtual() == NULL && ogoosepublish_ != NULL) delete ogoosepublish_;
  ogoosepublish_ = NULL;
}
inline const ::hqyGoose_Pub_Setting::Goose_Publish& IECPara::ogoosepublish() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.ogoosepublish)
  return ogoosepublish_ != NULL ? *ogoosepublish_
                         : *::hqyGoose_Pub_Setting::Goose_Publish::internal_default_instance();
}
inline ::hqyGoose_Pub_Setting::Goose_Publish* IECPara::mutable_ogoosepublish() {
  
  if (ogoosepublish_ == NULL) {
    ogoosepublish_ = new ::hqyGoose_Pub_Setting::Goose_Publish;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.ogoosepublish)
  return ogoosepublish_;
}
inline ::hqyGoose_Pub_Setting::Goose_Publish* IECPara::release_ogoosepublish() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.ogoosepublish)
  
  ::hqyGoose_Pub_Setting::Goose_Publish* temp = ogoosepublish_;
  ogoosepublish_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_ogoosepublish(::hqyGoose_Pub_Setting::Goose_Publish* ogoosepublish) {
  delete ogoosepublish_;
  ogoosepublish_ = ogoosepublish;
  if (ogoosepublish) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.ogoosepublish)
}

// .hqyGoose_Sub_Setting.Goose_Sub ogoosesub = 11;
inline bool IECPara::has_ogoosesub() const {
  return this != internal_default_instance() && ogoosesub_ != NULL;
}
inline void IECPara::clear_ogoosesub() {
  if (GetArenaNoVirtual() == NULL && ogoosesub_ != NULL) delete ogoosesub_;
  ogoosesub_ = NULL;
}
inline const ::hqyGoose_Sub_Setting::Goose_Sub& IECPara::ogoosesub() const {
  // @@protoc_insertion_point(field_get:hqyIECPara.IECPara.ogoosesub)
  return ogoosesub_ != NULL ? *ogoosesub_
                         : *::hqyGoose_Sub_Setting::Goose_Sub::internal_default_instance();
}
inline ::hqyGoose_Sub_Setting::Goose_Sub* IECPara::mutable_ogoosesub() {
  
  if (ogoosesub_ == NULL) {
    ogoosesub_ = new ::hqyGoose_Sub_Setting::Goose_Sub;
  }
  // @@protoc_insertion_point(field_mutable:hqyIECPara.IECPara.ogoosesub)
  return ogoosesub_;
}
inline ::hqyGoose_Sub_Setting::Goose_Sub* IECPara::release_ogoosesub() {
  // @@protoc_insertion_point(field_release:hqyIECPara.IECPara.ogoosesub)
  
  ::hqyGoose_Sub_Setting::Goose_Sub* temp = ogoosesub_;
  ogoosesub_ = NULL;
  return temp;
}
inline void IECPara::set_allocated_ogoosesub(::hqyGoose_Sub_Setting::Goose_Sub* ogoosesub) {
  delete ogoosesub_;
  ogoosesub_ = ogoosesub;
  if (ogoosesub) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:hqyIECPara.IECPara.ogoosesub)
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS

// @@protoc_insertion_point(namespace_scope)


}  // namespace hqyIECPara

#ifndef SWIG
namespace google {
namespace protobuf {

template <> struct is_proto_enum< ::hqyIECPara::digitalactype> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::hqyIECPara::digitalactype>() {
  return ::hqyIECPara::digitalactype_descriptor();
}

}  // namespace protobuf
}  // namespace google
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_hqyIECPara_2eproto__INCLUDED