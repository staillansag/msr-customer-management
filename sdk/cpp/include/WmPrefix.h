#ifdef WIN32
#undef PREFIX
#define PREFIX
#ifndef IMPORT_A_DLL
#define IMPORT_EXPORT_DLL   __declspec( dllexport )
#else
#define IMPORT_EXPORT_DLL   __declspec( dllimport )
#endif
#else
#undef IMPORT_EXPORT_DLL
#define IMPORT_EXPORT_DLL
#undef PREFIX
#define PREFIX
#endif
