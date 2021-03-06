// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: deviceinfogroup.proto

#define INTERNAL_SUPPRESS_PROTOBUF_FIELD_DEPRECATION
#include "deviceinfogroup.pb.h"

#include <algorithm>

#include <google/protobuf/stubs/common.h>
#include <google/protobuf/stubs/port.h>
#include <google/protobuf/stubs/once.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/wire_format_lite_inl.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/generated_message_reflection.h>
#include <google/protobuf/reflection_ops.h>
#include <google/protobuf/wire_format.h>
// @@protoc_insertion_point(includes)

namespace deviceinfogroup {
class infoDefaultTypeInternal : public ::google::protobuf::internal::ExplicitlyConstructed<info> {
} _info_default_instance_;
class setinfoDefaultTypeInternal : public ::google::protobuf::internal::ExplicitlyConstructed<setinfo> {
} _setinfo_default_instance_;

namespace protobuf_deviceinfogroup_2eproto {


namespace {

::google::protobuf::Metadata file_level_metadata[2];

}  // namespace

const ::google::protobuf::uint32 TableStruct::offsets[] = {
  ~0u,  // no _has_bits_
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, _internal_metadata_),
  ~0u,  // no _extensions_
  ~0u,  // no _oneof_case_
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, strip_),
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, ndevicenum_),
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, bhasanalog_),
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, nvoltchanelnum_),
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, ncurrentchanelnum_),
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, fvoltmax_),
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, fcurmax_),
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(info, bhasdigital_),
  ~0u,  // no _has_bits_
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(setinfo, _internal_metadata_),
  ~0u,  // no _extensions_
  ~0u,  // no _oneof_case_
  GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(setinfo, strip_),
};

static const ::google::protobuf::internal::MigrationSchema schemas[] = {
  { 0, -1, sizeof(info)},
  { 12, -1, sizeof(setinfo)},
};

static ::google::protobuf::Message const * const file_default_instances[] = {
  reinterpret_cast<const ::google::protobuf::Message*>(&_info_default_instance_),
  reinterpret_cast<const ::google::protobuf::Message*>(&_setinfo_default_instance_),
};

namespace {

void protobuf_AssignDescriptors() {
  AddDescriptors();
  ::google::protobuf::MessageFactory* factory = NULL;
  AssignDescriptors(
      "deviceinfogroup.proto", schemas, file_default_instances, TableStruct::offsets, factory,
      file_level_metadata, NULL, NULL);
}

void protobuf_AssignDescriptorsOnce() {
  static GOOGLE_PROTOBUF_DECLARE_ONCE(once);
  ::google::protobuf::GoogleOnceInit(&once, &protobuf_AssignDescriptors);
}

void protobuf_RegisterTypes(const ::std::string&) GOOGLE_ATTRIBUTE_COLD;
void protobuf_RegisterTypes(const ::std::string&) {
  protobuf_AssignDescriptorsOnce();
  ::google::protobuf::internal::RegisterAllTypes(file_level_metadata, 2);
}

}  // namespace

void TableStruct::Shutdown() {
  _info_default_instance_.Shutdown();
  delete file_level_metadata[0].reflection;
  _setinfo_default_instance_.Shutdown();
  delete file_level_metadata[1].reflection;
}

void TableStruct::InitDefaultsImpl() {
  GOOGLE_PROTOBUF_VERIFY_VERSION;

  ::google::protobuf::internal::InitProtobufDefaults();
  _info_default_instance_.DefaultConstruct();
  _setinfo_default_instance_.DefaultConstruct();
}

void InitDefaults() {
  static GOOGLE_PROTOBUF_DECLARE_ONCE(once);
  ::google::protobuf::GoogleOnceInit(&once, &TableStruct::InitDefaultsImpl);
}
void AddDescriptorsImpl() {
  InitDefaults();
  static const char descriptor[] = {
      "\n\025deviceinfogroup.proto\022\017deviceinfogroup"
      "\"\250\001\n\004info\022\r\n\005strip\030\001 \001(\t\022\022\n\nndevicenum\030\002"
      " \001(\r\022\022\n\nbhasanalog\030\003 \001(\010\022\026\n\016nvoltchaneln"
      "um\030\004 \001(\r\022\031\n\021ncurrentchanelnum\030\005 \001(\r\022\020\n\010f"
      "voltmax\030\006 \001(\002\022\017\n\007fcurmax\030\007 \001(\002\022\023\n\013bhasdi"
      "gital\030\010 \001(\010\"\030\n\007setinfo\022\r\n\005strip\030\001 \001(\tb\006p"
      "roto3"
  };
  ::google::protobuf::DescriptorPool::InternalAddGeneratedFile(
      descriptor, 245);
  ::google::protobuf::MessageFactory::InternalRegisterGeneratedFile(
    "deviceinfogroup.proto", &protobuf_RegisterTypes);
  ::google::protobuf::internal::OnShutdown(&TableStruct::Shutdown);
}

void AddDescriptors() {
  static GOOGLE_PROTOBUF_DECLARE_ONCE(once);
  ::google::protobuf::GoogleOnceInit(&once, &AddDescriptorsImpl);
}
// Force AddDescriptors() to be called at static initialization time.
struct StaticDescriptorInitializer {
  StaticDescriptorInitializer() {
    AddDescriptors();
  }
} static_descriptor_initializer;

}  // namespace protobuf_deviceinfogroup_2eproto


// ===================================================================

#if !defined(_MSC_VER) || _MSC_VER >= 1900
const int info::kStripFieldNumber;
const int info::kNdevicenumFieldNumber;
const int info::kBhasanalogFieldNumber;
const int info::kNvoltchanelnumFieldNumber;
const int info::kNcurrentchanelnumFieldNumber;
const int info::kFvoltmaxFieldNumber;
const int info::kFcurmaxFieldNumber;
const int info::kBhasdigitalFieldNumber;
#endif  // !defined(_MSC_VER) || _MSC_VER >= 1900

info::info()
  : ::google::protobuf::Message(), _internal_metadata_(NULL) {
  if (GOOGLE_PREDICT_TRUE(this != internal_default_instance())) {
    protobuf_deviceinfogroup_2eproto::InitDefaults();
  }
  SharedCtor();
  // @@protoc_insertion_point(constructor:deviceinfogroup.info)
}
info::info(const info& from)
  : ::google::protobuf::Message(),
      _internal_metadata_(NULL),
      _cached_size_(0) {
  _internal_metadata_.MergeFrom(from._internal_metadata_);
  strip_.UnsafeSetDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  if (from.strip().size() > 0) {
    strip_.AssignWithDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), from.strip_);
  }
  ::memcpy(&ndevicenum_, &from.ndevicenum_,
    reinterpret_cast<char*>(&fcurmax_) -
    reinterpret_cast<char*>(&ndevicenum_) + sizeof(fcurmax_));
  // @@protoc_insertion_point(copy_constructor:deviceinfogroup.info)
}

void info::SharedCtor() {
  strip_.UnsafeSetDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  ::memset(&ndevicenum_, 0, reinterpret_cast<char*>(&fcurmax_) -
    reinterpret_cast<char*>(&ndevicenum_) + sizeof(fcurmax_));
  _cached_size_ = 0;
}

info::~info() {
  // @@protoc_insertion_point(destructor:deviceinfogroup.info)
  SharedDtor();
}

void info::SharedDtor() {
  strip_.DestroyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}

void info::SetCachedSize(int size) const {
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
}
const ::google::protobuf::Descriptor* info::descriptor() {
  protobuf_deviceinfogroup_2eproto::protobuf_AssignDescriptorsOnce();
  return protobuf_deviceinfogroup_2eproto::file_level_metadata[0].descriptor;
}

const info& info::default_instance() {
  protobuf_deviceinfogroup_2eproto::InitDefaults();
  return *internal_default_instance();
}

info* info::New(::google::protobuf::Arena* arena) const {
  info* n = new info;
  if (arena != NULL) {
    arena->Own(n);
  }
  return n;
}

void info::Clear() {
// @@protoc_insertion_point(message_clear_start:deviceinfogroup.info)
  strip_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  ::memset(&ndevicenum_, 0, reinterpret_cast<char*>(&fcurmax_) -
    reinterpret_cast<char*>(&ndevicenum_) + sizeof(fcurmax_));
}

bool info::MergePartialFromCodedStream(
    ::google::protobuf::io::CodedInputStream* input) {
#define DO_(EXPRESSION) if (!GOOGLE_PREDICT_TRUE(EXPRESSION)) goto failure
  ::google::protobuf::uint32 tag;
  // @@protoc_insertion_point(parse_start:deviceinfogroup.info)
  for (;;) {
    ::std::pair< ::google::protobuf::uint32, bool> p = input->ReadTagWithCutoffNoLastTag(127u);
    tag = p.first;
    if (!p.second) goto handle_unusual;
    switch (::google::protobuf::internal::WireFormatLite::GetTagFieldNumber(tag)) {
      // string strip = 1;
      case 1: {
        if (tag == 10u) {
          DO_(::google::protobuf::internal::WireFormatLite::ReadString(
                input, this->mutable_strip()));
          DO_(::google::protobuf::internal::WireFormatLite::VerifyUtf8String(
            this->strip().data(), this->strip().length(),
            ::google::protobuf::internal::WireFormatLite::PARSE,
            "deviceinfogroup.info.strip"));
        } else {
          goto handle_unusual;
        }
        break;
      }

      // uint32 ndevicenum = 2;
      case 2: {
        if (tag == 16u) {

          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::uint32, ::google::protobuf::internal::WireFormatLite::TYPE_UINT32>(
                 input, &ndevicenum_)));
        } else {
          goto handle_unusual;
        }
        break;
      }

      // bool bhasanalog = 3;
      case 3: {
        if (tag == 24u) {

          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   bool, ::google::protobuf::internal::WireFormatLite::TYPE_BOOL>(
                 input, &bhasanalog_)));
        } else {
          goto handle_unusual;
        }
        break;
      }

      // uint32 nvoltchanelnum = 4;
      case 4: {
        if (tag == 32u) {

          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::uint32, ::google::protobuf::internal::WireFormatLite::TYPE_UINT32>(
                 input, &nvoltchanelnum_)));
        } else {
          goto handle_unusual;
        }
        break;
      }

      // uint32 ncurrentchanelnum = 5;
      case 5: {
        if (tag == 40u) {

          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::uint32, ::google::protobuf::internal::WireFormatLite::TYPE_UINT32>(
                 input, &ncurrentchanelnum_)));
        } else {
          goto handle_unusual;
        }
        break;
      }

      // float fvoltmax = 6;
      case 6: {
        if (tag == 53u) {

          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   float, ::google::protobuf::internal::WireFormatLite::TYPE_FLOAT>(
                 input, &fvoltmax_)));
        } else {
          goto handle_unusual;
        }
        break;
      }

      // float fcurmax = 7;
      case 7: {
        if (tag == 61u) {

          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   float, ::google::protobuf::internal::WireFormatLite::TYPE_FLOAT>(
                 input, &fcurmax_)));
        } else {
          goto handle_unusual;
        }
        break;
      }

      // bool bhasdigital = 8;
      case 8: {
        if (tag == 64u) {

          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   bool, ::google::protobuf::internal::WireFormatLite::TYPE_BOOL>(
                 input, &bhasdigital_)));
        } else {
          goto handle_unusual;
        }
        break;
      }

      default: {
      handle_unusual:
        if (tag == 0 ||
            ::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_END_GROUP) {
          goto success;
        }
        DO_(::google::protobuf::internal::WireFormatLite::SkipField(input, tag));
        break;
      }
    }
  }
success:
  // @@protoc_insertion_point(parse_success:deviceinfogroup.info)
  return true;
failure:
  // @@protoc_insertion_point(parse_failure:deviceinfogroup.info)
  return false;
#undef DO_
}

void info::SerializeWithCachedSizes(
    ::google::protobuf::io::CodedOutputStream* output) const {
  // @@protoc_insertion_point(serialize_start:deviceinfogroup.info)
  // string strip = 1;
  if (this->strip().size() > 0) {
    ::google::protobuf::internal::WireFormatLite::VerifyUtf8String(
      this->strip().data(), this->strip().length(),
      ::google::protobuf::internal::WireFormatLite::SERIALIZE,
      "deviceinfogroup.info.strip");
    ::google::protobuf::internal::WireFormatLite::WriteStringMaybeAliased(
      1, this->strip(), output);
  }

  // uint32 ndevicenum = 2;
  if (this->ndevicenum() != 0) {
    ::google::protobuf::internal::WireFormatLite::WriteUInt32(2, this->ndevicenum(), output);
  }

  // bool bhasanalog = 3;
  if (this->bhasanalog() != 0) {
    ::google::protobuf::internal::WireFormatLite::WriteBool(3, this->bhasanalog(), output);
  }

  // uint32 nvoltchanelnum = 4;
  if (this->nvoltchanelnum() != 0) {
    ::google::protobuf::internal::WireFormatLite::WriteUInt32(4, this->nvoltchanelnum(), output);
  }

  // uint32 ncurrentchanelnum = 5;
  if (this->ncurrentchanelnum() != 0) {
    ::google::protobuf::internal::WireFormatLite::WriteUInt32(5, this->ncurrentchanelnum(), output);
  }

  // float fvoltmax = 6;
  if (this->fvoltmax() != 0) {
    ::google::protobuf::internal::WireFormatLite::WriteFloat(6, this->fvoltmax(), output);
  }

  // float fcurmax = 7;
  if (this->fcurmax() != 0) {
    ::google::protobuf::internal::WireFormatLite::WriteFloat(7, this->fcurmax(), output);
  }

  // bool bhasdigital = 8;
  if (this->bhasdigital() != 0) {
    ::google::protobuf::internal::WireFormatLite::WriteBool(8, this->bhasdigital(), output);
  }

  // @@protoc_insertion_point(serialize_end:deviceinfogroup.info)
}

::google::protobuf::uint8* info::InternalSerializeWithCachedSizesToArray(
    bool deterministic, ::google::protobuf::uint8* target) const {
  (void)deterministic;  // Unused
  // @@protoc_insertion_point(serialize_to_array_start:deviceinfogroup.info)
  // string strip = 1;
  if (this->strip().size() > 0) {
    ::google::protobuf::internal::WireFormatLite::VerifyUtf8String(
      this->strip().data(), this->strip().length(),
      ::google::protobuf::internal::WireFormatLite::SERIALIZE,
      "deviceinfogroup.info.strip");
    target =
      ::google::protobuf::internal::WireFormatLite::WriteStringToArray(
        1, this->strip(), target);
  }

  // uint32 ndevicenum = 2;
  if (this->ndevicenum() != 0) {
    target = ::google::protobuf::internal::WireFormatLite::WriteUInt32ToArray(2, this->ndevicenum(), target);
  }

  // bool bhasanalog = 3;
  if (this->bhasanalog() != 0) {
    target = ::google::protobuf::internal::WireFormatLite::WriteBoolToArray(3, this->bhasanalog(), target);
  }

  // uint32 nvoltchanelnum = 4;
  if (this->nvoltchanelnum() != 0) {
    target = ::google::protobuf::internal::WireFormatLite::WriteUInt32ToArray(4, this->nvoltchanelnum(), target);
  }

  // uint32 ncurrentchanelnum = 5;
  if (this->ncurrentchanelnum() != 0) {
    target = ::google::protobuf::internal::WireFormatLite::WriteUInt32ToArray(5, this->ncurrentchanelnum(), target);
  }

  // float fvoltmax = 6;
  if (this->fvoltmax() != 0) {
    target = ::google::protobuf::internal::WireFormatLite::WriteFloatToArray(6, this->fvoltmax(), target);
  }

  // float fcurmax = 7;
  if (this->fcurmax() != 0) {
    target = ::google::protobuf::internal::WireFormatLite::WriteFloatToArray(7, this->fcurmax(), target);
  }

  // bool bhasdigital = 8;
  if (this->bhasdigital() != 0) {
    target = ::google::protobuf::internal::WireFormatLite::WriteBoolToArray(8, this->bhasdigital(), target);
  }

  // @@protoc_insertion_point(serialize_to_array_end:deviceinfogroup.info)
  return target;
}

size_t info::ByteSizeLong() const {
// @@protoc_insertion_point(message_byte_size_start:deviceinfogroup.info)
  size_t total_size = 0;

  // string strip = 1;
  if (this->strip().size() > 0) {
    total_size += 1 +
      ::google::protobuf::internal::WireFormatLite::StringSize(
        this->strip());
  }

  // uint32 ndevicenum = 2;
  if (this->ndevicenum() != 0) {
    total_size += 1 +
      ::google::protobuf::internal::WireFormatLite::UInt32Size(
        this->ndevicenum());
  }

  // uint32 nvoltchanelnum = 4;
  if (this->nvoltchanelnum() != 0) {
    total_size += 1 +
      ::google::protobuf::internal::WireFormatLite::UInt32Size(
        this->nvoltchanelnum());
  }

  // uint32 ncurrentchanelnum = 5;
  if (this->ncurrentchanelnum() != 0) {
    total_size += 1 +
      ::google::protobuf::internal::WireFormatLite::UInt32Size(
        this->ncurrentchanelnum());
  }

  // bool bhasanalog = 3;
  if (this->bhasanalog() != 0) {
    total_size += 1 + 1;
  }

  // bool bhasdigital = 8;
  if (this->bhasdigital() != 0) {
    total_size += 1 + 1;
  }

  // float fvoltmax = 6;
  if (this->fvoltmax() != 0) {
    total_size += 1 + 4;
  }

  // float fcurmax = 7;
  if (this->fcurmax() != 0) {
    total_size += 1 + 4;
  }

  int cached_size = ::google::protobuf::internal::ToCachedSize(total_size);
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = cached_size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
  return total_size;
}

void info::MergeFrom(const ::google::protobuf::Message& from) {
// @@protoc_insertion_point(generalized_merge_from_start:deviceinfogroup.info)
  GOOGLE_DCHECK_NE(&from, this);
  const info* source =
      ::google::protobuf::internal::DynamicCastToGenerated<const info>(
          &from);
  if (source == NULL) {
  // @@protoc_insertion_point(generalized_merge_from_cast_fail:deviceinfogroup.info)
    ::google::protobuf::internal::ReflectionOps::Merge(from, this);
  } else {
  // @@protoc_insertion_point(generalized_merge_from_cast_success:deviceinfogroup.info)
    MergeFrom(*source);
  }
}

void info::MergeFrom(const info& from) {
// @@protoc_insertion_point(class_specific_merge_from_start:deviceinfogroup.info)
  GOOGLE_DCHECK_NE(&from, this);
  _internal_metadata_.MergeFrom(from._internal_metadata_);
  if (from.strip().size() > 0) {

    strip_.AssignWithDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), from.strip_);
  }
  if (from.ndevicenum() != 0) {
    set_ndevicenum(from.ndevicenum());
  }
  if (from.nvoltchanelnum() != 0) {
    set_nvoltchanelnum(from.nvoltchanelnum());
  }
  if (from.ncurrentchanelnum() != 0) {
    set_ncurrentchanelnum(from.ncurrentchanelnum());
  }
  if (from.bhasanalog() != 0) {
    set_bhasanalog(from.bhasanalog());
  }
  if (from.bhasdigital() != 0) {
    set_bhasdigital(from.bhasdigital());
  }
  if (from.fvoltmax() != 0) {
    set_fvoltmax(from.fvoltmax());
  }
  if (from.fcurmax() != 0) {
    set_fcurmax(from.fcurmax());
  }
}

void info::CopyFrom(const ::google::protobuf::Message& from) {
// @@protoc_insertion_point(generalized_copy_from_start:deviceinfogroup.info)
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

void info::CopyFrom(const info& from) {
// @@protoc_insertion_point(class_specific_copy_from_start:deviceinfogroup.info)
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

bool info::IsInitialized() const {
  return true;
}

void info::Swap(info* other) {
  if (other == this) return;
  InternalSwap(other);
}
void info::InternalSwap(info* other) {
  strip_.Swap(&other->strip_);
  std::swap(ndevicenum_, other->ndevicenum_);
  std::swap(nvoltchanelnum_, other->nvoltchanelnum_);
  std::swap(ncurrentchanelnum_, other->ncurrentchanelnum_);
  std::swap(bhasanalog_, other->bhasanalog_);
  std::swap(bhasdigital_, other->bhasdigital_);
  std::swap(fvoltmax_, other->fvoltmax_);
  std::swap(fcurmax_, other->fcurmax_);
  std::swap(_cached_size_, other->_cached_size_);
}

::google::protobuf::Metadata info::GetMetadata() const {
  protobuf_deviceinfogroup_2eproto::protobuf_AssignDescriptorsOnce();
  return protobuf_deviceinfogroup_2eproto::file_level_metadata[0];
}

#if PROTOBUF_INLINE_NOT_IN_HEADERS
// info

// string strip = 1;
void info::clear_strip() {
  strip_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
const ::std::string& info::strip() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.strip)
  return strip_.GetNoArena();
}
void info::set_strip(const ::std::string& value) {
  
  strip_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.strip)
}
#if LANG_CXX11
void info::set_strip(::std::string&& value) {
  
  strip_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:deviceinfogroup.info.strip)
}
#endif
void info::set_strip(const char* value) {
  
  strip_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:deviceinfogroup.info.strip)
}
void info::set_strip(const char* value, size_t size) {
  
  strip_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:deviceinfogroup.info.strip)
}
::std::string* info::mutable_strip() {
  
  // @@protoc_insertion_point(field_mutable:deviceinfogroup.info.strip)
  return strip_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
::std::string* info::release_strip() {
  // @@protoc_insertion_point(field_release:deviceinfogroup.info.strip)
  
  return strip_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
void info::set_allocated_strip(::std::string* strip) {
  if (strip != NULL) {
    
  } else {
    
  }
  strip_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), strip);
  // @@protoc_insertion_point(field_set_allocated:deviceinfogroup.info.strip)
}

// uint32 ndevicenum = 2;
void info::clear_ndevicenum() {
  ndevicenum_ = 0u;
}
::google::protobuf::uint32 info::ndevicenum() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.ndevicenum)
  return ndevicenum_;
}
void info::set_ndevicenum(::google::protobuf::uint32 value) {
  
  ndevicenum_ = value;
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.ndevicenum)
}

// bool bhasanalog = 3;
void info::clear_bhasanalog() {
  bhasanalog_ = false;
}
bool info::bhasanalog() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.bhasanalog)
  return bhasanalog_;
}
void info::set_bhasanalog(bool value) {
  
  bhasanalog_ = value;
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.bhasanalog)
}

// uint32 nvoltchanelnum = 4;
void info::clear_nvoltchanelnum() {
  nvoltchanelnum_ = 0u;
}
::google::protobuf::uint32 info::nvoltchanelnum() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.nvoltchanelnum)
  return nvoltchanelnum_;
}
void info::set_nvoltchanelnum(::google::protobuf::uint32 value) {
  
  nvoltchanelnum_ = value;
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.nvoltchanelnum)
}

// uint32 ncurrentchanelnum = 5;
void info::clear_ncurrentchanelnum() {
  ncurrentchanelnum_ = 0u;
}
::google::protobuf::uint32 info::ncurrentchanelnum() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.ncurrentchanelnum)
  return ncurrentchanelnum_;
}
void info::set_ncurrentchanelnum(::google::protobuf::uint32 value) {
  
  ncurrentchanelnum_ = value;
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.ncurrentchanelnum)
}

// float fvoltmax = 6;
void info::clear_fvoltmax() {
  fvoltmax_ = 0;
}
float info::fvoltmax() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.fvoltmax)
  return fvoltmax_;
}
void info::set_fvoltmax(float value) {
  
  fvoltmax_ = value;
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.fvoltmax)
}

// float fcurmax = 7;
void info::clear_fcurmax() {
  fcurmax_ = 0;
}
float info::fcurmax() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.fcurmax)
  return fcurmax_;
}
void info::set_fcurmax(float value) {
  
  fcurmax_ = value;
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.fcurmax)
}

// bool bhasdigital = 8;
void info::clear_bhasdigital() {
  bhasdigital_ = false;
}
bool info::bhasdigital() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.info.bhasdigital)
  return bhasdigital_;
}
void info::set_bhasdigital(bool value) {
  
  bhasdigital_ = value;
  // @@protoc_insertion_point(field_set:deviceinfogroup.info.bhasdigital)
}

#endif  // PROTOBUF_INLINE_NOT_IN_HEADERS

// ===================================================================

#if !defined(_MSC_VER) || _MSC_VER >= 1900
const int setinfo::kStripFieldNumber;
#endif  // !defined(_MSC_VER) || _MSC_VER >= 1900

setinfo::setinfo()
  : ::google::protobuf::Message(), _internal_metadata_(NULL) {
  if (GOOGLE_PREDICT_TRUE(this != internal_default_instance())) {
    protobuf_deviceinfogroup_2eproto::InitDefaults();
  }
  SharedCtor();
  // @@protoc_insertion_point(constructor:deviceinfogroup.setinfo)
}
setinfo::setinfo(const setinfo& from)
  : ::google::protobuf::Message(),
      _internal_metadata_(NULL),
      _cached_size_(0) {
  _internal_metadata_.MergeFrom(from._internal_metadata_);
  strip_.UnsafeSetDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  if (from.strip().size() > 0) {
    strip_.AssignWithDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), from.strip_);
  }
  // @@protoc_insertion_point(copy_constructor:deviceinfogroup.setinfo)
}

void setinfo::SharedCtor() {
  strip_.UnsafeSetDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
  _cached_size_ = 0;
}

setinfo::~setinfo() {
  // @@protoc_insertion_point(destructor:deviceinfogroup.setinfo)
  SharedDtor();
}

void setinfo::SharedDtor() {
  strip_.DestroyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}

void setinfo::SetCachedSize(int size) const {
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
}
const ::google::protobuf::Descriptor* setinfo::descriptor() {
  protobuf_deviceinfogroup_2eproto::protobuf_AssignDescriptorsOnce();
  return protobuf_deviceinfogroup_2eproto::file_level_metadata[1].descriptor;
}

const setinfo& setinfo::default_instance() {
  protobuf_deviceinfogroup_2eproto::InitDefaults();
  return *internal_default_instance();
}

setinfo* setinfo::New(::google::protobuf::Arena* arena) const {
  setinfo* n = new setinfo;
  if (arena != NULL) {
    arena->Own(n);
  }
  return n;
}

void setinfo::Clear() {
// @@protoc_insertion_point(message_clear_start:deviceinfogroup.setinfo)
  strip_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}

bool setinfo::MergePartialFromCodedStream(
    ::google::protobuf::io::CodedInputStream* input) {
#define DO_(EXPRESSION) if (!GOOGLE_PREDICT_TRUE(EXPRESSION)) goto failure
  ::google::protobuf::uint32 tag;
  // @@protoc_insertion_point(parse_start:deviceinfogroup.setinfo)
  for (;;) {
    ::std::pair< ::google::protobuf::uint32, bool> p = input->ReadTagWithCutoffNoLastTag(127u);
    tag = p.first;
    if (!p.second) goto handle_unusual;
    switch (::google::protobuf::internal::WireFormatLite::GetTagFieldNumber(tag)) {
      // string strip = 1;
      case 1: {
        if (tag == 10u) {
          DO_(::google::protobuf::internal::WireFormatLite::ReadString(
                input, this->mutable_strip()));
          DO_(::google::protobuf::internal::WireFormatLite::VerifyUtf8String(
            this->strip().data(), this->strip().length(),
            ::google::protobuf::internal::WireFormatLite::PARSE,
            "deviceinfogroup.setinfo.strip"));
        } else {
          goto handle_unusual;
        }
        break;
      }

      default: {
      handle_unusual:
        if (tag == 0 ||
            ::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_END_GROUP) {
          goto success;
        }
        DO_(::google::protobuf::internal::WireFormatLite::SkipField(input, tag));
        break;
      }
    }
  }
success:
  // @@protoc_insertion_point(parse_success:deviceinfogroup.setinfo)
  return true;
failure:
  // @@protoc_insertion_point(parse_failure:deviceinfogroup.setinfo)
  return false;
#undef DO_
}

void setinfo::SerializeWithCachedSizes(
    ::google::protobuf::io::CodedOutputStream* output) const {
  // @@protoc_insertion_point(serialize_start:deviceinfogroup.setinfo)
  // string strip = 1;
  if (this->strip().size() > 0) {
    ::google::protobuf::internal::WireFormatLite::VerifyUtf8String(
      this->strip().data(), this->strip().length(),
      ::google::protobuf::internal::WireFormatLite::SERIALIZE,
      "deviceinfogroup.setinfo.strip");
    ::google::protobuf::internal::WireFormatLite::WriteStringMaybeAliased(
      1, this->strip(), output);
  }

  // @@protoc_insertion_point(serialize_end:deviceinfogroup.setinfo)
}

::google::protobuf::uint8* setinfo::InternalSerializeWithCachedSizesToArray(
    bool deterministic, ::google::protobuf::uint8* target) const {
  (void)deterministic;  // Unused
  // @@protoc_insertion_point(serialize_to_array_start:deviceinfogroup.setinfo)
  // string strip = 1;
  if (this->strip().size() > 0) {
    ::google::protobuf::internal::WireFormatLite::VerifyUtf8String(
      this->strip().data(), this->strip().length(),
      ::google::protobuf::internal::WireFormatLite::SERIALIZE,
      "deviceinfogroup.setinfo.strip");
    target =
      ::google::protobuf::internal::WireFormatLite::WriteStringToArray(
        1, this->strip(), target);
  }

  // @@protoc_insertion_point(serialize_to_array_end:deviceinfogroup.setinfo)
  return target;
}

size_t setinfo::ByteSizeLong() const {
// @@protoc_insertion_point(message_byte_size_start:deviceinfogroup.setinfo)
  size_t total_size = 0;

  // string strip = 1;
  if (this->strip().size() > 0) {
    total_size += 1 +
      ::google::protobuf::internal::WireFormatLite::StringSize(
        this->strip());
  }

  int cached_size = ::google::protobuf::internal::ToCachedSize(total_size);
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = cached_size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
  return total_size;
}

void setinfo::MergeFrom(const ::google::protobuf::Message& from) {
// @@protoc_insertion_point(generalized_merge_from_start:deviceinfogroup.setinfo)
  GOOGLE_DCHECK_NE(&from, this);
  const setinfo* source =
      ::google::protobuf::internal::DynamicCastToGenerated<const setinfo>(
          &from);
  if (source == NULL) {
  // @@protoc_insertion_point(generalized_merge_from_cast_fail:deviceinfogroup.setinfo)
    ::google::protobuf::internal::ReflectionOps::Merge(from, this);
  } else {
  // @@protoc_insertion_point(generalized_merge_from_cast_success:deviceinfogroup.setinfo)
    MergeFrom(*source);
  }
}

void setinfo::MergeFrom(const setinfo& from) {
// @@protoc_insertion_point(class_specific_merge_from_start:deviceinfogroup.setinfo)
  GOOGLE_DCHECK_NE(&from, this);
  _internal_metadata_.MergeFrom(from._internal_metadata_);
  if (from.strip().size() > 0) {

    strip_.AssignWithDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), from.strip_);
  }
}

void setinfo::CopyFrom(const ::google::protobuf::Message& from) {
// @@protoc_insertion_point(generalized_copy_from_start:deviceinfogroup.setinfo)
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

void setinfo::CopyFrom(const setinfo& from) {
// @@protoc_insertion_point(class_specific_copy_from_start:deviceinfogroup.setinfo)
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

bool setinfo::IsInitialized() const {
  return true;
}

void setinfo::Swap(setinfo* other) {
  if (other == this) return;
  InternalSwap(other);
}
void setinfo::InternalSwap(setinfo* other) {
  strip_.Swap(&other->strip_);
  std::swap(_cached_size_, other->_cached_size_);
}

::google::protobuf::Metadata setinfo::GetMetadata() const {
  protobuf_deviceinfogroup_2eproto::protobuf_AssignDescriptorsOnce();
  return protobuf_deviceinfogroup_2eproto::file_level_metadata[1];
}

#if PROTOBUF_INLINE_NOT_IN_HEADERS
// setinfo

// string strip = 1;
void setinfo::clear_strip() {
  strip_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
const ::std::string& setinfo::strip() const {
  // @@protoc_insertion_point(field_get:deviceinfogroup.setinfo.strip)
  return strip_.GetNoArena();
}
void setinfo::set_strip(const ::std::string& value) {
  
  strip_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:deviceinfogroup.setinfo.strip)
}
#if LANG_CXX11
void setinfo::set_strip(::std::string&& value) {
  
  strip_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:deviceinfogroup.setinfo.strip)
}
#endif
void setinfo::set_strip(const char* value) {
  
  strip_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:deviceinfogroup.setinfo.strip)
}
void setinfo::set_strip(const char* value, size_t size) {
  
  strip_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:deviceinfogroup.setinfo.strip)
}
::std::string* setinfo::mutable_strip() {
  
  // @@protoc_insertion_point(field_mutable:deviceinfogroup.setinfo.strip)
  return strip_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
::std::string* setinfo::release_strip() {
  // @@protoc_insertion_point(field_release:deviceinfogroup.setinfo.strip)
  
  return strip_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
void setinfo::set_allocated_strip(::std::string* strip) {
  if (strip != NULL) {
    
  } else {
    
  }
  strip_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), strip);
  // @@protoc_insertion_point(field_set_allocated:deviceinfogroup.setinfo.strip)
}

#endif  // PROTOBUF_INLINE_NOT_IN_HEADERS

// @@protoc_insertion_point(namespace_scope)

}  // namespace deviceinfogroup

// @@protoc_insertion_point(global_scope)
