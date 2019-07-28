// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: TesterOutputPara.proto

#ifndef PROTOBUF_TesterOutputPara_2eproto__INCLUDED
#define PROTOBUF_TesterOutputPara_2eproto__INCLUDED

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
namespace TesterOutputPara {
class AC6U6I;
class AC6U6IDefaultTypeInternal;
extern AC6U6IDefaultTypeInternal _AC6U6I_default_instance_;
class ChanelMode;
class ChanelModeDefaultTypeInternal;
extern ChanelModeDefaultTypeInternal _ChanelMode_default_instance_;
class ChanelPara;
class ChanelParaDefaultTypeInternal;
extern ChanelParaDefaultTypeInternal _ChanelPara_default_instance_;
}  // namespace TesterOutputPara

namespace TesterOutputPara {

namespace protobuf_TesterOutputPara_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_TesterOutputPara_2eproto

// ===================================================================

class ChanelPara : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:TesterOutputPara.ChanelPara) */ {
 public:
  ChanelPara();
  virtual ~ChanelPara();

  ChanelPara(const ChanelPara& from);

  inline ChanelPara& operator=(const ChanelPara& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const ChanelPara& default_instance();

  static inline const ChanelPara* internal_default_instance() {
    return reinterpret_cast<const ChanelPara*>(
               &_ChanelPara_default_instance_);
  }

  void Swap(ChanelPara* other);

  // implements Message ----------------------------------------------

  inline ChanelPara* New() const PROTOBUF_FINAL { return New(NULL); }

  ChanelPara* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const ChanelPara& from);
  void MergeFrom(const ChanelPara& from);
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
  void InternalSwap(ChanelPara* other);
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

  // float famptitude = 1;
  void clear_famptitude();
  static const int kFamptitudeFieldNumber = 1;
  float famptitude() const;
  void set_famptitude(float value);

  // float fphase = 2;
  void clear_fphase();
  static const int kFphaseFieldNumber = 2;
  float fphase() const;
  void set_fphase(float value);

  // float ffre = 3;
  void clear_ffre();
  static const int kFfreFieldNumber = 3;
  float ffre() const;
  void set_ffre(float value);

  // @@protoc_insertion_point(class_scope:TesterOutputPara.ChanelPara)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  float famptitude_;
  float fphase_;
  float ffre_;
  mutable int _cached_size_;
  friend struct  protobuf_TesterOutputPara_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class ChanelMode : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:TesterOutputPara.ChanelMode) */ {
 public:
  ChanelMode();
  virtual ~ChanelMode();

  ChanelMode(const ChanelMode& from);

  inline ChanelMode& operator=(const ChanelMode& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const ChanelMode& default_instance();

  static inline const ChanelMode* internal_default_instance() {
    return reinterpret_cast<const ChanelMode*>(
               &_ChanelMode_default_instance_);
  }

  void Swap(ChanelMode* other);

  // implements Message ----------------------------------------------

  inline ChanelMode* New() const PROTOBUF_FINAL { return New(NULL); }

  ChanelMode* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const ChanelMode& from);
  void MergeFrom(const ChanelMode& from);
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
  void InternalSwap(ChanelMode* other);
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

  // repeated .TesterOutputPara.ChanelPara oCurChanel = 1;
  int ocurchanel_size() const;
  void clear_ocurchanel();
  static const int kOCurChanelFieldNumber = 1;
  const ::TesterOutputPara::ChanelPara& ocurchanel(int index) const;
  ::TesterOutputPara::ChanelPara* mutable_ocurchanel(int index);
  ::TesterOutputPara::ChanelPara* add_ocurchanel();
  ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >*
      mutable_ocurchanel();
  const ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >&
      ocurchanel() const;

  // repeated .TesterOutputPara.ChanelPara oVolChanel = 2;
  int ovolchanel_size() const;
  void clear_ovolchanel();
  static const int kOVolChanelFieldNumber = 2;
  const ::TesterOutputPara::ChanelPara& ovolchanel(int index) const;
  ::TesterOutputPara::ChanelPara* mutable_ovolchanel(int index);
  ::TesterOutputPara::ChanelPara* add_ovolchanel();
  ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >*
      mutable_ovolchanel();
  const ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >&
      ovolchanel() const;

  // @@protoc_insertion_point(class_scope:TesterOutputPara.ChanelMode)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara > ocurchanel_;
  ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara > ovolchanel_;
  mutable int _cached_size_;
  friend struct  protobuf_TesterOutputPara_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class AC6U6I : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:TesterOutputPara.AC6U6I) */ {
 public:
  AC6U6I();
  virtual ~AC6U6I();

  AC6U6I(const AC6U6I& from);

  inline AC6U6I& operator=(const AC6U6I& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const AC6U6I& default_instance();

  static inline const AC6U6I* internal_default_instance() {
    return reinterpret_cast<const AC6U6I*>(
               &_AC6U6I_default_instance_);
  }

  void Swap(AC6U6I* other);

  // implements Message ----------------------------------------------

  inline AC6U6I* New() const PROTOBUF_FINAL { return New(NULL); }

  AC6U6I* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const AC6U6I& from);
  void MergeFrom(const AC6U6I& from);
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
  void InternalSwap(AC6U6I* other);
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

  // .TesterOutputPara.ChanelMode oChanel = 1;
  bool has_ochanel() const;
  void clear_ochanel();
  static const int kOChanelFieldNumber = 1;
  const ::TesterOutputPara::ChanelMode& ochanel() const;
  ::TesterOutputPara::ChanelMode* mutable_ochanel();
  ::TesterOutputPara::ChanelMode* release_ochanel();
  void set_allocated_ochanel(::TesterOutputPara::ChanelMode* ochanel);

  // @@protoc_insertion_point(class_scope:TesterOutputPara.AC6U6I)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::TesterOutputPara::ChanelMode* ochanel_;
  mutable int _cached_size_;
  friend struct  protobuf_TesterOutputPara_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// ChanelPara

// float famptitude = 1;
inline void ChanelPara::clear_famptitude() {
  famptitude_ = 0;
}
inline float ChanelPara::famptitude() const {
  // @@protoc_insertion_point(field_get:TesterOutputPara.ChanelPara.famptitude)
  return famptitude_;
}
inline void ChanelPara::set_famptitude(float value) {
  
  famptitude_ = value;
  // @@protoc_insertion_point(field_set:TesterOutputPara.ChanelPara.famptitude)
}

// float fphase = 2;
inline void ChanelPara::clear_fphase() {
  fphase_ = 0;
}
inline float ChanelPara::fphase() const {
  // @@protoc_insertion_point(field_get:TesterOutputPara.ChanelPara.fphase)
  return fphase_;
}
inline void ChanelPara::set_fphase(float value) {
  
  fphase_ = value;
  // @@protoc_insertion_point(field_set:TesterOutputPara.ChanelPara.fphase)
}

// float ffre = 3;
inline void ChanelPara::clear_ffre() {
  ffre_ = 0;
}
inline float ChanelPara::ffre() const {
  // @@protoc_insertion_point(field_get:TesterOutputPara.ChanelPara.ffre)
  return ffre_;
}
inline void ChanelPara::set_ffre(float value) {
  
  ffre_ = value;
  // @@protoc_insertion_point(field_set:TesterOutputPara.ChanelPara.ffre)
}

// -------------------------------------------------------------------

// ChanelMode

// repeated .TesterOutputPara.ChanelPara oCurChanel = 1;
inline int ChanelMode::ocurchanel_size() const {
  return ocurchanel_.size();
}
inline void ChanelMode::clear_ocurchanel() {
  ocurchanel_.Clear();
}
inline const ::TesterOutputPara::ChanelPara& ChanelMode::ocurchanel(int index) const {
  // @@protoc_insertion_point(field_get:TesterOutputPara.ChanelMode.oCurChanel)
  return ocurchanel_.Get(index);
}
inline ::TesterOutputPara::ChanelPara* ChanelMode::mutable_ocurchanel(int index) {
  // @@protoc_insertion_point(field_mutable:TesterOutputPara.ChanelMode.oCurChanel)
  return ocurchanel_.Mutable(index);
}
inline ::TesterOutputPara::ChanelPara* ChanelMode::add_ocurchanel() {
  // @@protoc_insertion_point(field_add:TesterOutputPara.ChanelMode.oCurChanel)
  return ocurchanel_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >*
ChanelMode::mutable_ocurchanel() {
  // @@protoc_insertion_point(field_mutable_list:TesterOutputPara.ChanelMode.oCurChanel)
  return &ocurchanel_;
}
inline const ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >&
ChanelMode::ocurchanel() const {
  // @@protoc_insertion_point(field_list:TesterOutputPara.ChanelMode.oCurChanel)
  return ocurchanel_;
}

// repeated .TesterOutputPara.ChanelPara oVolChanel = 2;
inline int ChanelMode::ovolchanel_size() const {
  return ovolchanel_.size();
}
inline void ChanelMode::clear_ovolchanel() {
  ovolchanel_.Clear();
}
inline const ::TesterOutputPara::ChanelPara& ChanelMode::ovolchanel(int index) const {
  // @@protoc_insertion_point(field_get:TesterOutputPara.ChanelMode.oVolChanel)
  return ovolchanel_.Get(index);
}
inline ::TesterOutputPara::ChanelPara* ChanelMode::mutable_ovolchanel(int index) {
  // @@protoc_insertion_point(field_mutable:TesterOutputPara.ChanelMode.oVolChanel)
  return ovolchanel_.Mutable(index);
}
inline ::TesterOutputPara::ChanelPara* ChanelMode::add_ovolchanel() {
  // @@protoc_insertion_point(field_add:TesterOutputPara.ChanelMode.oVolChanel)
  return ovolchanel_.Add();
}
inline ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >*
ChanelMode::mutable_ovolchanel() {
  // @@protoc_insertion_point(field_mutable_list:TesterOutputPara.ChanelMode.oVolChanel)
  return &ovolchanel_;
}
inline const ::google::protobuf::RepeatedPtrField< ::TesterOutputPara::ChanelPara >&
ChanelMode::ovolchanel() const {
  // @@protoc_insertion_point(field_list:TesterOutputPara.ChanelMode.oVolChanel)
  return ovolchanel_;
}

// -------------------------------------------------------------------

// AC6U6I

// .TesterOutputPara.ChanelMode oChanel = 1;
inline bool AC6U6I::has_ochanel() const {
  return this != internal_default_instance() && ochanel_ != NULL;
}
inline void AC6U6I::clear_ochanel() {
  if (GetArenaNoVirtual() == NULL && ochanel_ != NULL) delete ochanel_;
  ochanel_ = NULL;
}
inline const ::TesterOutputPara::ChanelMode& AC6U6I::ochanel() const {
  // @@protoc_insertion_point(field_get:TesterOutputPara.AC6U6I.oChanel)
  return ochanel_ != NULL ? *ochanel_
                         : *::TesterOutputPara::ChanelMode::internal_default_instance();
}
inline ::TesterOutputPara::ChanelMode* AC6U6I::mutable_ochanel() {
  
  if (ochanel_ == NULL) {
    ochanel_ = new ::TesterOutputPara::ChanelMode;
  }
  // @@protoc_insertion_point(field_mutable:TesterOutputPara.AC6U6I.oChanel)
  return ochanel_;
}
inline ::TesterOutputPara::ChanelMode* AC6U6I::release_ochanel() {
  // @@protoc_insertion_point(field_release:TesterOutputPara.AC6U6I.oChanel)
  
  ::TesterOutputPara::ChanelMode* temp = ochanel_;
  ochanel_ = NULL;
  return temp;
}
inline void AC6U6I::set_allocated_ochanel(::TesterOutputPara::ChanelMode* ochanel) {
  delete ochanel_;
  ochanel_ = ochanel;
  if (ochanel) {
    
  } else {
    
  }
  // @@protoc_insertion_point(field_set_allocated:TesterOutputPara.AC6U6I.oChanel)
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------

// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace TesterOutputPara

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_TesterOutputPara_2eproto__INCLUDED