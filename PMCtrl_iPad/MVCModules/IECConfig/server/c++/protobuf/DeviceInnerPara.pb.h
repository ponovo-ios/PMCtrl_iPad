// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: DeviceInnerPara.proto

#ifndef PROTOBUF_DeviceInnerPara_2eproto__INCLUDED
#define PROTOBUF_DeviceInnerPara_2eproto__INCLUDED

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
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)
namespace DeviceInnerPara {
class AmplifierVolt;
class AmplifierVoltDefaultTypeInternal;
extern AmplifierVoltDefaultTypeInternal _AmplifierVolt_default_instance_;
class DASetting;
class DASettingDefaultTypeInternal;
extern DASettingDefaultTypeInternal _DASetting_default_instance_;
class DASettings;
class DASettingsDefaultTypeInternal;
extern DASettingsDefaultTypeInternal _DASettings_default_instance_;
class DeviceInnerSetting;
class DeviceInnerSettingDefaultTypeInternal;
extern DeviceInnerSettingDefaultTypeInternal _DeviceInnerSetting_default_instance_;
class ModuleInfo;
class ModuleInfoDefaultTypeInternal;
extern ModuleInfoDefaultTypeInternal _ModuleInfo_default_instance_;
}  // namespace DeviceInnerPara

namespace DeviceInnerPara {

namespace protobuf_DeviceInnerPara_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_DeviceInnerPara_2eproto

// ===================================================================

class DeviceInnerSetting : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:DeviceInnerPara.DeviceInnerSetting) */ {
 public:
  DeviceInnerSetting();
  virtual ~DeviceInnerSetting();

  DeviceInnerSetting(const DeviceInnerSetting& from);

  inline DeviceInnerSetting& operator=(const DeviceInnerSetting& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const DeviceInnerSetting& default_instance();

  static inline const DeviceInnerSetting* internal_default_instance() {
    return reinterpret_cast<const DeviceInnerSetting*>(
               &_DeviceInnerSetting_default_instance_);
  }

  void Swap(DeviceInnerSetting* other);

  // implements Message ----------------------------------------------

  inline DeviceInnerSetting* New() const PROTOBUF_FINAL { return New(NULL); }

  DeviceInnerSetting* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const DeviceInnerSetting& from);
  void MergeFrom(const DeviceInnerSetting& from);
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
  void InternalSwap(DeviceInnerSetting* other);
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

  // .DeviceInnerPara.AmplifierVolt oAmplifierVolt = 2;
  bool has_oamplifiervolt() const;
  void clear_oamplifiervolt();
  static const int kOAmplifierVoltFieldNumber = 2;
  const ::DeviceInnerPara::AmplifierVolt& oamplifiervolt() const;
  ::DeviceInnerPara::AmplifierVolt* mutable_oamplifiervolt();
  ::DeviceInnerPara::AmplifierVolt* release_oamplifiervolt();
  void set_allocated_oamplifiervolt(::DeviceInnerPara::AmplifierVolt* oamplifiervolt);

  // uint32 nModule = 3;
  void clear_nmodule();
  static const int kNModuleFieldNumber = 3;
  ::google::protobuf::uint32 nmodule() const;
  void set_nmodule(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:DeviceInnerPara.DeviceInnerSetting)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::DeviceInnerPara::AmplifierVolt* oamplifiervolt_;
  ::google::protobuf::uint32 nmodule_;
  mutable int _cached_size_;
  friend struct  protobuf_DeviceInnerPara_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class ModuleInfo : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:DeviceInnerPara.ModuleInfo) */ {
 public:
  ModuleInfo();
  virtual ~ModuleInfo();

  ModuleInfo(const ModuleInfo& from);

  inline ModuleInfo& operator=(const ModuleInfo& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const ModuleInfo& default_instance();

  static inline const ModuleInfo* internal_default_instance() {
    return reinterpret_cast<const ModuleInfo*>(
               &_ModuleInfo_default_instance_);
  }

  void Swap(ModuleInfo* other);

  // implements Message ----------------------------------------------

  inline ModuleInfo* New() const PROTOBUF_FINAL { return New(NULL); }

  ModuleInfo* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const ModuleInfo& from);
  void MergeFrom(const ModuleInfo& from);
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
  void InternalSwap(ModuleInfo* other);
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

  // repeated .DeviceInnerPara.DeviceInnerSetting oInnerSetting = 1;
  int oinnersetting_size() const;
  void clear_oinnersetting();
  static const int kOInnerSettingFieldNumber = 1;
  const ::DeviceInnerPara::DeviceInnerSetting& oinnersetting(int index) const;
  ::DeviceInnerPara::DeviceInnerSetting* mutable_oinnersetting(int index);
  ::DeviceInnerPara::DeviceInnerSetting* add_oinnersetting();
  ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DeviceInnerSetting >*
      mutable_oinnersetting();
  const ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DeviceInnerSetting >&
      oinnersetting() const;

  // @@protoc_insertion_point(class_scope:DeviceInnerPara.ModuleInfo)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DeviceInnerSetting > oinnersetting_;
  mutable int _cached_size_;
  friend struct  protobuf_DeviceInnerPara_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class DASettings : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:DeviceInnerPara.DASettings) */ {
 public:
  DASettings();
  virtual ~DASettings();

  DASettings(const DASettings& from);

  inline DASettings& operator=(const DASettings& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const DASettings& default_instance();

  static inline const DASettings* internal_default_instance() {
    return reinterpret_cast<const DASettings*>(
               &_DASettings_default_instance_);
  }

  void Swap(DASettings* other);

  // implements Message ----------------------------------------------

  inline DASettings* New() const PROTOBUF_FINAL { return New(NULL); }

  DASettings* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const DASettings& from);
  void MergeFrom(const DASettings& from);
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
  void InternalSwap(DASettings* other);
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

  // repeated .DeviceInnerPara.DASetting odas = 1;
  int odas_size() const;
  void clear_odas();
  static const int kOdasFieldNumber = 1;
  const ::DeviceInnerPara::DASetting& odas(int index) const;
  ::DeviceInnerPara::DASetting* mutable_odas(int index);
  ::DeviceInnerPara::DASetting* add_odas();
  ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DASetting >*
      mutable_odas();
  const ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DASetting >&
      odas() const;

  // @@protoc_insertion_point(class_scope:DeviceInnerPara.DASettings)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DASetting > odas_;
  mutable int _cached_size_;
  friend struct  protobuf_DeviceInnerPara_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class DASetting : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:DeviceInnerPara.DASetting) */ {
 public:
  DASetting();
  virtual ~DASetting();

  DASetting(const DASetting& from);

  inline DASetting& operator=(const DASetting& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const DASetting& default_instance();

  static inline const DASetting* internal_default_instance() {
    return reinterpret_cast<const DASetting*>(
               &_DASetting_default_instance_);
  }

  void Swap(DASetting* other);

  // implements Message ----------------------------------------------

  inline DASetting* New() const PROTOBUF_FINAL { return New(NULL); }

  DASetting* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const DASetting& from);
  void MergeFrom(const DASetting& from);
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
  void InternalSwap(DASetting* other);
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

  // repeated float fVolt = 1;
  int fvolt_size() const;
  void clear_fvolt();
  static const int kFVoltFieldNumber = 1;
  float fvolt(int index) const;
  void set_fvolt(int index, float value);
  void add_fvolt(float value);
  const ::google::protobuf::RepeatedField< float >&
      fvolt() const;
  ::google::protobuf::RepeatedField< float >*
      mutable_fvolt();

  // @@protoc_insertion_point(class_scope:DeviceInnerPara.DASetting)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedField< float > fvolt_;
  mutable int _fvolt_cached_byte_size_;
  mutable int _cached_size_;
  friend struct  protobuf_DeviceInnerPara_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class AmplifierVolt : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:DeviceInnerPara.AmplifierVolt) */ {
 public:
  AmplifierVolt();
  virtual ~AmplifierVolt();

  AmplifierVolt(const AmplifierVolt& from);

  inline AmplifierVolt& operator=(const AmplifierVolt& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const AmplifierVolt& default_instance();

  static inline const AmplifierVolt* internal_default_instance() {
    return reinterpret_cast<const AmplifierVolt*>(
               &_AmplifierVolt_default_instance_);
  }

  void Swap(AmplifierVolt* other);

  // implements Message ----------------------------------------------

  inline AmplifierVolt* New() const PROTOBUF_FINAL { return New(NULL); }

  AmplifierVolt* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const AmplifierVolt& from);
  void MergeFrom(const AmplifierVolt& from);
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
  void InternalSwap(AmplifierVolt* other);
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

  // repeated float fVoltMax = 1;
  int fvoltmax_size() const;
  void clear_fvoltmax();
  static const int kFVoltMaxFieldNumber = 1;
  float fvoltmax(int index) const;
  void set_fvoltmax(int index, float value);
  void add_fvoltmax(float value);
  const ::google::protobuf::RepeatedField< float >&
      fvoltmax() const;
  ::google::protobuf::RepeatedField< float >*
      mutable_fvoltmax();

  // repeated float fVoltMin = 2;
  int fvoltmin_size() const;
  void clear_fvoltmin();
  static const int kFVoltMinFieldNumber = 2;
  float fvoltmin(int index) const;
  void set_fvoltmin(int index, float value);
  void add_fvoltmin(float value);
  const ::google::protobuf::RepeatedField< float >&
      fvoltmin() const;
  ::google::protobuf::RepeatedField< float >*
      mutable_fvoltmin();

  // repeated float fVoltDc = 3;
  int fvoltdc_size() const;
  void clear_fvoltdc();
  static const int kFVoltDcFieldNumber = 3;
  float fvoltdc(int index) const;
  void set_fvoltdc(int index, float value);
  void add_fvoltdc(float value);
  const ::google::protobuf::RepeatedField< float >&
      fvoltdc() const;
  ::google::protobuf::RepeatedField< float >*
      mutable_fvoltdc();

  // repeated uint32 bVoltOverLoad = 4;
  int bvoltoverload_size() const;
  void clear_bvoltoverload();
  static const int kBVoltOverLoadFieldNumber = 4;
  ::google::protobuf::uint32 bvoltoverload(int index) const;
  void set_bvoltoverload(int index, ::google::protobuf::uint32 value);
  void add_bvoltoverload(::google::protobuf::uint32 value);
  const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
      bvoltoverload() const;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
      mutable_bvoltoverload();

  // repeated uint32 nTemp = 5;
  int ntemp_size() const;
  void clear_ntemp();
  static const int kNTempFieldNumber = 5;
  ::google::protobuf::uint32 ntemp(int index) const;
  void set_ntemp(int index, ::google::protobuf::uint32 value);
  void add_ntemp(::google::protobuf::uint32 value);
  const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
      ntemp() const;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
      mutable_ntemp();

  // uint32 nVoltOverHot = 6;
  void clear_nvoltoverhot();
  static const int kNVoltOverHotFieldNumber = 6;
  ::google::protobuf::uint32 nvoltoverhot() const;
  void set_nvoltoverhot(::google::protobuf::uint32 value);

  // uint32 bDCOverHot = 7;
  void clear_bdcoverhot();
  static const int kBDCOverHotFieldNumber = 7;
  ::google::protobuf::uint32 bdcoverhot() const;
  void set_bdcoverhot(::google::protobuf::uint32 value);

  // uint32 voltwarining = 8;
  void clear_voltwarining();
  static const int kVoltwariningFieldNumber = 8;
  ::google::protobuf::uint32 voltwarining() const;
  void set_voltwarining(::google::protobuf::uint32 value);

  // uint32 misswarining = 9;
  void clear_misswarining();
  static const int kMisswariningFieldNumber = 9;
  ::google::protobuf::uint32 misswarining() const;
  void set_misswarining(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:DeviceInnerPara.AmplifierVolt)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedField< float > fvoltmax_;
  mutable int _fvoltmax_cached_byte_size_;
  ::google::protobuf::RepeatedField< float > fvoltmin_;
  mutable int _fvoltmin_cached_byte_size_;
  ::google::protobuf::RepeatedField< float > fvoltdc_;
  mutable int _fvoltdc_cached_byte_size_;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 > bvoltoverload_;
  mutable int _bvoltoverload_cached_byte_size_;
  ::google::protobuf::RepeatedField< ::google::protobuf::uint32 > ntemp_;
  mutable int _ntemp_cached_byte_size_;
  ::google::protobuf::uint32 nvoltoverhot_;
  ::google::protobuf::uint32 bdcoverhot_;
  ::google::protobuf::uint32 voltwarining_;
  ::google::protobuf::uint32 misswarining_;
  mutable int _cached_size_;
  friend struct  protobuf_DeviceInnerPara_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// DeviceInnerSetting

// .DeviceInnerPara.AmplifierVolt oAmplifierVolt = 2;
inline bool DeviceInnerSetting::has_oamplifiervolt() const {
  return this != internal_default_instance() && oamplifiervolt_ != NULL;
}
inline void DeviceInnerSetting::clear_oamplifiervolt() {
  if (GetArenaNoVirtual() == NULL && oamplifiervolt_ != NULL) delete oamplifiervolt_;
  oamplifiervolt_ = NULL;
}
inline const ::DeviceInnerPara::AmplifierVolt& DeviceInnerSetting::oamplifiervolt() const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.DeviceInnerSetting.oAmplifierVolt)
  return oamplifiervolt_ != NULL ? *oamplifiervolt_
                         : *::DeviceInnerPara::AmplifierVolt::internal_default_instance();
}
inline ::DeviceInnerPara::AmplifierVolt* DeviceInnerSetting::mutable_oamplifiervolt() {
  
  if (oamplifiervolt_ == NULL) {
    oamplifiervolt_ = new ::DeviceInnerPara::AmplifierVolt;
  }
  // @@protoc_insertion_point(field_mutable:DeviceInnerPara.DeviceInnerSetting.oAmplifierVolt)
  return oamplifiervolt_;
}
inline ::DeviceInnerPara::AmplifierVolt* DeviceInnerSetting::release_oamplifiervolt() {
  // @@protoc_insertion_point(field_release:DeviceInnerPara.DeviceInnerSetting.oAmplifierVolt)
  
  ::DeviceInnerPara::AmplifierVolt* temp = oamplifiervolt_;
  oamplifiervolt_ = NULL;
  return temp;
}
inline void DeviceInnerSetting::set_allocated_oamplifiervolt(::DeviceInnerPara::AmplifierVolt* oamplifiervolt) {
  delete oamplifiervolt_;
  oamplifiervolt_ = oamplifiervolt;
  if (oamplifiervolt) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:DeviceInnerPara.DeviceInnerSetting.oAmplifierVolt)
}

// uint32 nModule = 3;
inline void DeviceInnerSetting::clear_nmodule() {
  nmodule_ = 0u;
}
inline ::google::protobuf::uint32 DeviceInnerSetting::nmodule() const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.DeviceInnerSetting.nModule)
  return nmodule_;
}
inline void DeviceInnerSetting::set_nmodule(::google::protobuf::uint32 value) {
  
  nmodule_ = value;
  // @@protoc_insertion_point(field_set:DeviceInnerPara.DeviceInnerSetting.nModule)
}

// -------------------------------------------------------------------

// ModuleInfo

// repeated .DeviceInnerPara.DeviceInnerSetting oInnerSetting = 1;
inline int ModuleInfo::oinnersetting_size() const {
  return oinnersetting_.size();
}
inline void ModuleInfo::clear_oinnersetting() {
  oinnersetting_.Clear();
}
inline const ::DeviceInnerPara::DeviceInnerSetting& ModuleInfo::oinnersetting(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.ModuleInfo.oInnerSetting)
  return oinnersetting_.Get(index);
}
inline ::DeviceInnerPara::DeviceInnerSetting* ModuleInfo::mutable_oinnersetting(int index) {
  // @@protoc_insertion_point(field_mutable:DeviceInnerPara.ModuleInfo.oInnerSetting)
  return oinnersetting_.Mutable(index);
}
inline ::DeviceInnerPara::DeviceInnerSetting* ModuleInfo::add_oinnersetting() {
  // @@protoc_insertion_point(field_add:DeviceInnerPara.ModuleInfo.oInnerSetting)
  return oinnersetting_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DeviceInnerSetting >*
ModuleInfo::mutable_oinnersetting() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.ModuleInfo.oInnerSetting)
  return &oinnersetting_;
}
inline const ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DeviceInnerSetting >&
ModuleInfo::oinnersetting() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.ModuleInfo.oInnerSetting)
  return oinnersetting_;
}

// -------------------------------------------------------------------

// DASettings

// repeated .DeviceInnerPara.DASetting odas = 1;
inline int DASettings::odas_size() const {
  return odas_.size();
}
inline void DASettings::clear_odas() {
  odas_.Clear();
}
inline const ::DeviceInnerPara::DASetting& DASettings::odas(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.DASettings.odas)
  return odas_.Get(index);
}
inline ::DeviceInnerPara::DASetting* DASettings::mutable_odas(int index) {
  // @@protoc_insertion_point(field_mutable:DeviceInnerPara.DASettings.odas)
  return odas_.Mutable(index);
}
inline ::DeviceInnerPara::DASetting* DASettings::add_odas() {
  // @@protoc_insertion_point(field_add:DeviceInnerPara.DASettings.odas)
  return odas_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DASetting >*
DASettings::mutable_odas() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.DASettings.odas)
  return &odas_;
}
inline const ::google::protobuf::RepeatedPtrField< ::DeviceInnerPara::DASetting >&
DASettings::odas() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.DASettings.odas)
  return odas_;
}

// -------------------------------------------------------------------

// DASetting

// repeated float fVolt = 1;
inline int DASetting::fvolt_size() const {
  return fvolt_.size();
}
inline void DASetting::clear_fvolt() {
  fvolt_.Clear();
}
inline float DASetting::fvolt(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.DASetting.fVolt)
  return fvolt_.Get(index);
}
inline void DASetting::set_fvolt(int index, float value) {
  fvolt_.Set(index, value);
  // @@protoc_insertion_point(field_set:DeviceInnerPara.DASetting.fVolt)
}
inline void DASetting::add_fvolt(float value) {
  fvolt_.Add(value);
  // @@protoc_insertion_point(field_add:DeviceInnerPara.DASetting.fVolt)
}
inline const ::google::protobuf::RepeatedField< float >&
DASetting::fvolt() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.DASetting.fVolt)
  return fvolt_;
}
inline ::google::protobuf::RepeatedField< float >*
DASetting::mutable_fvolt() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.DASetting.fVolt)
  return &fvolt_;
}

// -------------------------------------------------------------------

// AmplifierVolt

// repeated float fVoltMax = 1;
inline int AmplifierVolt::fvoltmax_size() const {
  return fvoltmax_.size();
}
inline void AmplifierVolt::clear_fvoltmax() {
  fvoltmax_.Clear();
}
inline float AmplifierVolt::fvoltmax(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.fVoltMax)
  return fvoltmax_.Get(index);
}
inline void AmplifierVolt::set_fvoltmax(int index, float value) {
  fvoltmax_.Set(index, value);
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.fVoltMax)
}
inline void AmplifierVolt::add_fvoltmax(float value) {
  fvoltmax_.Add(value);
  // @@protoc_insertion_point(field_add:DeviceInnerPara.AmplifierVolt.fVoltMax)
}
inline const ::google::protobuf::RepeatedField< float >&
AmplifierVolt::fvoltmax() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.AmplifierVolt.fVoltMax)
  return fvoltmax_;
}
inline ::google::protobuf::RepeatedField< float >*
AmplifierVolt::mutable_fvoltmax() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.AmplifierVolt.fVoltMax)
  return &fvoltmax_;
}

// repeated float fVoltMin = 2;
inline int AmplifierVolt::fvoltmin_size() const {
  return fvoltmin_.size();
}
inline void AmplifierVolt::clear_fvoltmin() {
  fvoltmin_.Clear();
}
inline float AmplifierVolt::fvoltmin(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.fVoltMin)
  return fvoltmin_.Get(index);
}
inline void AmplifierVolt::set_fvoltmin(int index, float value) {
  fvoltmin_.Set(index, value);
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.fVoltMin)
}
inline void AmplifierVolt::add_fvoltmin(float value) {
  fvoltmin_.Add(value);
  // @@protoc_insertion_point(field_add:DeviceInnerPara.AmplifierVolt.fVoltMin)
}
inline const ::google::protobuf::RepeatedField< float >&
AmplifierVolt::fvoltmin() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.AmplifierVolt.fVoltMin)
  return fvoltmin_;
}
inline ::google::protobuf::RepeatedField< float >*
AmplifierVolt::mutable_fvoltmin() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.AmplifierVolt.fVoltMin)
  return &fvoltmin_;
}

// repeated float fVoltDc = 3;
inline int AmplifierVolt::fvoltdc_size() const {
  return fvoltdc_.size();
}
inline void AmplifierVolt::clear_fvoltdc() {
  fvoltdc_.Clear();
}
inline float AmplifierVolt::fvoltdc(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.fVoltDc)
  return fvoltdc_.Get(index);
}
inline void AmplifierVolt::set_fvoltdc(int index, float value) {
  fvoltdc_.Set(index, value);
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.fVoltDc)
}
inline void AmplifierVolt::add_fvoltdc(float value) {
  fvoltdc_.Add(value);
  // @@protoc_insertion_point(field_add:DeviceInnerPara.AmplifierVolt.fVoltDc)
}
inline const ::google::protobuf::RepeatedField< float >&
AmplifierVolt::fvoltdc() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.AmplifierVolt.fVoltDc)
  return fvoltdc_;
}
inline ::google::protobuf::RepeatedField< float >*
AmplifierVolt::mutable_fvoltdc() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.AmplifierVolt.fVoltDc)
  return &fvoltdc_;
}

// repeated uint32 bVoltOverLoad = 4;
inline int AmplifierVolt::bvoltoverload_size() const {
  return bvoltoverload_.size();
}
inline void AmplifierVolt::clear_bvoltoverload() {
  bvoltoverload_.Clear();
}
inline ::google::protobuf::uint32 AmplifierVolt::bvoltoverload(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.bVoltOverLoad)
  return bvoltoverload_.Get(index);
}
inline void AmplifierVolt::set_bvoltoverload(int index, ::google::protobuf::uint32 value) {
  bvoltoverload_.Set(index, value);
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.bVoltOverLoad)
}
inline void AmplifierVolt::add_bvoltoverload(::google::protobuf::uint32 value) {
  bvoltoverload_.Add(value);
  // @@protoc_insertion_point(field_add:DeviceInnerPara.AmplifierVolt.bVoltOverLoad)
}
inline const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
AmplifierVolt::bvoltoverload() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.AmplifierVolt.bVoltOverLoad)
  return bvoltoverload_;
}
inline ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
AmplifierVolt::mutable_bvoltoverload() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.AmplifierVolt.bVoltOverLoad)
  return &bvoltoverload_;
}

// repeated uint32 nTemp = 5;
inline int AmplifierVolt::ntemp_size() const {
  return ntemp_.size();
}
inline void AmplifierVolt::clear_ntemp() {
  ntemp_.Clear();
}
inline ::google::protobuf::uint32 AmplifierVolt::ntemp(int index) const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.nTemp)
  return ntemp_.Get(index);
}
inline void AmplifierVolt::set_ntemp(int index, ::google::protobuf::uint32 value) {
  ntemp_.Set(index, value);
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.nTemp)
}
inline void AmplifierVolt::add_ntemp(::google::protobuf::uint32 value) {
  ntemp_.Add(value);
  // @@protoc_insertion_point(field_add:DeviceInnerPara.AmplifierVolt.nTemp)
}
inline const ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >&
AmplifierVolt::ntemp() const {
  // @@protoc_insertion_point(field_list:DeviceInnerPara.AmplifierVolt.nTemp)
  return ntemp_;
}
inline ::google::protobuf::RepeatedField< ::google::protobuf::uint32 >*
AmplifierVolt::mutable_ntemp() {
  // @@protoc_insertion_point(field_mutable_list:DeviceInnerPara.AmplifierVolt.nTemp)
  return &ntemp_;
}

// uint32 nVoltOverHot = 6;
inline void AmplifierVolt::clear_nvoltoverhot() {
  nvoltoverhot_ = 0u;
}
inline ::google::protobuf::uint32 AmplifierVolt::nvoltoverhot() const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.nVoltOverHot)
  return nvoltoverhot_;
}
inline void AmplifierVolt::set_nvoltoverhot(::google::protobuf::uint32 value) {
  
  nvoltoverhot_ = value;
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.nVoltOverHot)
}

// uint32 bDCOverHot = 7;
inline void AmplifierVolt::clear_bdcoverhot() {
  bdcoverhot_ = 0u;
}
inline ::google::protobuf::uint32 AmplifierVolt::bdcoverhot() const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.bDCOverHot)
  return bdcoverhot_;
}
inline void AmplifierVolt::set_bdcoverhot(::google::protobuf::uint32 value) {
  
  bdcoverhot_ = value;
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.bDCOverHot)
}

// uint32 voltwarining = 8;
inline void AmplifierVolt::clear_voltwarining() {
  voltwarining_ = 0u;
}
inline ::google::protobuf::uint32 AmplifierVolt::voltwarining() const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.voltwarining)
  return voltwarining_;
}
inline void AmplifierVolt::set_voltwarining(::google::protobuf::uint32 value) {
  
  voltwarining_ = value;
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.voltwarining)
}

// uint32 misswarining = 9;
inline void AmplifierVolt::clear_misswarining() {
  misswarining_ = 0u;
}
inline ::google::protobuf::uint32 AmplifierVolt::misswarining() const {
  // @@protoc_insertion_point(field_get:DeviceInnerPara.AmplifierVolt.misswarining)
  return misswarining_;
}
inline void AmplifierVolt::set_misswarining(::google::protobuf::uint32 value) {
  
  misswarining_ = value;
  // @@protoc_insertion_point(field_set:DeviceInnerPara.AmplifierVolt.misswarining)
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------

// -------------------------------------------------------------------

// -------------------------------------------------------------------

// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace DeviceInnerPara

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_DeviceInnerPara_2eproto__INCLUDED
