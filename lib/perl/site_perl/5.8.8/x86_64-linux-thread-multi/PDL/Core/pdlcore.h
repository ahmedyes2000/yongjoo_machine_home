/*
 * THIS FILE IS GENERATED FROM pdlcore.h.PL! Do NOT edit!
 */

#ifndef __PDLCORE_H
#define __PDLCORE_H

#include "EXTERN.h"   /* std perl include */
#include "perl.h"     /* std perl include */
#include "XSUB.h"  /* for the win32 perlCAPI crap */
#include "ppport.h"  /* include this AFTER XSUB.h */

#if defined(CONTEXT) && defined(__osf__)
#undef CONTEXT
#endif

#include "pdl.h"
#include "pdlthread.h"
/* the next one causes trouble in c++ compiles - exclude for now */
#ifndef __cplusplus
#include "pdlmagic.h"
#endif

#define PDL_CORE_VERSION 6

#define PDL_TMP  0        /* Flags */
#define PDL_PERM 1

#define BIGGESTOF(a,b) ( a->nvals>b->nvals ? a->nvals : b->nvals )
#define SVavref(x) (SvROK(x) && SvTYPE(SvRV(x))==SVt_PVAV)

/* Create portable NaN's with the NaN_float and NaN_double macros.
 * The end values are 7f to turn off sign bit to avoid printing "-NaN".
 * This produces QNaN's or quiet nan's on architectures that support it.
 *
 * The below uses IEEE-754, so it should be portable.  Also note the symmetry
 * which makes the bigendian vs little-endian issue moot.  If platforms should
 * arise which require further consideration, use the pdl function,
 * PDL::Core::Dev::isbigendian() which returns a boolean value (a false value
 * garantees little-endian), and #ifdef's for exotic architectures.  You'll be
 * hard pressed to find an architecture that doesn't support ieee-754 but does
 * support NaN.  See http://en.wikipedia.org/wiki/NaN to understand why
 * this works. */
static const union {unsigned char c[4]; float f;}
   union_nan_float = {{0x7f, 0xff, 0xff, 0x7f}};
static const union {unsigned char c[8]; double d;}
   union_nan_double = {{0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f}};

/* for the moment we go back to the original croak
 * since there seem to be quite a few problems with maintaining
 * our own barf version
 */

#define barf croak

typedef int Logical;

/*************** Function prototypes *********************/


/* pdlcore.c */

int     pdl_howbig (int datatype);           /* Size of data type (bytes) */
pdl*    SvPDLV ( SV* sv );                   /* Map SV* to pdl struct */
void	SetSV_PDL( SV *sv, pdl *it );	     /* Outputting a pdl from.. */
SV*     pdl_copy( pdl* a, char* option );     /* call copy method */
PDL_Long *    pdl_packdims ( SV* sv, int*ndims ); /* Pack dims[] into SV aref */
void    pdl_unpackdims ( SV* sv, PDL_Long *dims,  /* Unpack */
                         int ndims );
void*   pdl_malloc ( int nbytes );           /* malloc memory - auto free()*/

void pdl_makescratchhash(pdl *ret,double data, int datatype);
PDL_Long pdl_safe_indterm(PDL_Long dsz, PDL_Long at, char *file, int lineno);
void pdl_barf(const char* pat,...); /* General croaking utility */
int av_ndcheck(AV* av, AV* dims, int level, int *datalevel);
pdl* pdl_from_array(AV* av, AV* dims, int type, pdl* p);

long pdl_setav_Long(PDL_Long* pdata, AV* av,
	PDL_Long* pdims, PDL_Long ndims, int level, double undefval);
long pdl_setav_Float(PDL_Float* pdata, AV* av,
	PDL_Long* pdims, PDL_Long ndims, int level, double undefval);
long pdl_setav_Short(PDL_Short* pdata, AV* av,
	PDL_Long* pdims, PDL_Long ndims, int level, double undefval);
long pdl_setav_Ushort(PDL_Ushort* pdata, AV* av,
	PDL_Long* pdims, PDL_Long ndims, int level, double undefval);
long pdl_setav_Double(PDL_Double* pdata, AV* av,
	PDL_Long* pdims, PDL_Long ndims, int level, double undefval);
long pdl_setav_Byte(PDL_Byte* pdata, AV* av,
	PDL_Long* pdims, PDL_Long ndims, int level, double undefval);
long pdl_setav_LongLong(PDL_LongLong* pdata, AV* av,
	PDL_Long* pdims, PDL_Long ndims, int level, double undefval);

/* pdlapi.c */

void pdl_vaffinechanged(pdl *it, int what);
void pdl_trans_mallocfreeproc(struct pdl_trans *tr);
void pdl_make_trans_mutual(pdl_trans *trans);
void pdl_destroytransform_nonmutual(pdl_trans *trans,int ensure);

void pdl_vafftrans_free(pdl *it);
void pdl_vafftrans_remove(pdl * it);
void pdl_make_physvaffine(pdl *it);
void pdl_vafftrans_alloc(pdl *it);

pdl *pdl_null();
pdl *pdl_get_convertedpdl(pdl *pdl,int type);

void pdl_destroytransform(pdl_trans *trans,int ensure);
pdl *pdl_make_now(pdl *it);

pdl *pdl_hard_copy(pdl *src);

#define pdl_new() pdl_create(PDL_PERM)
#define pdl_tmp() pdl_create(PDL_TMP)
pdl* pdl_external_new();
pdl* pdl_external_tmp();
pdl* pdl_create(int type);
void pdl_destroy(pdl *it);
void pdl_setdims(pdl* it, PDL_Long* dims, int ndims);
void pdl_reallocdims ( pdl *it,int ndims );  /* reallocate dims and incs */
void pdl_reallocthreadids ( pdl *it,int ndims );  /* reallocate threadids */
void pdl_resize_defaultincs ( pdl *it );     /* Make incs out of dims */
void pdl_unpackarray ( HV* hash, char *key, int *dims, int ndims );
void pdl_print(pdl *it);
void pdl_dump(pdl *it);
void pdl_allocdata(pdl *it);

int *pdl_get_threadoffsp(pdl_thread *thread); /* For pthreading */
void pdl_thread_copy(pdl_thread *from,pdl_thread *to);
void pdl_clearthreadstruct(pdl_thread *it);
void pdl_initthreadstruct(int nobl,pdl **pdls,int *realdims,int *creating,int npdls,
	pdl_errorinfo *info,pdl_thread *thread,char *flags);
int pdl_startthreadloop(pdl_thread *thread,void (*func)(pdl_trans *),pdl_trans *);
int pdl_iterthreadloop(pdl_thread *thread,int which);
void pdl_freethreadloop(pdl_thread *thread);
void pdl_thread_create_parameter(pdl_thread *thread,int j,int *dims,
				 int temp);
void pdl_croak_param(pdl_errorinfo *info,int j, char *pat, ...);

void pdl_setdims_careful(pdl *pdl);
void pdl_put_offs(pdl *pdl,PDL_Long offs, double val);
double pdl_get_offs(pdl *pdl,PDL_Long offs);
double pdl_get(pdl *pdl,int *inds);
void pdl_set_trans(pdl *it, pdl *parent, pdl_transvtable *vtable);

void pdl_make_physical(pdl *it);
void pdl_make_physdims(pdl *it);

void pdl_children_changesoon(pdl *it, int what);
void pdl_changed(pdl *it, int what, int recursing);
void pdl_separatefromparent(pdl *it);

void pdl_trans_changesoon(pdl_trans *trans,int what);
void pdl_trans_changed(pdl_trans *trans,int what);

void pdl_set_trans_childtrans(pdl *it, pdl_trans *trans,int nth);
void pdl_set_trans_parenttrans(pdl *it, pdl_trans *trans,int nth);

/* pdlhash.c */

pdl*    pdl_getcache( HV* hash );       /* Retrieve address of $$x{PDL} */
pdl*    pdl_fillcache( HV* hash, SV* ref);       /* Fill/create $$x{PDL} cache */
void    pdl_fillcache_partial( HV *hash, pdl *thepdl ) ;
SV*     pdl_getKey( HV* hash, char* key );  /* Get $$x{Key} SV* with deref */
void pdl_flushcache( pdl *thepdl );	     /* flush cache */

/* pdlfamily.c */

void pdl_family_create(pdl *from,pdl_trans *trans,int ind1,int ind2);
pdl *pdl_family_clone2now(pdl *from); /* Use pdl_make_now instead */


/* pdlconv.c */

void pdl_writebackdata_vaffine(pdl *it);
void pdl_readdata_vaffine(pdl *it);

void   pdl_swap(pdl** a, pdl** b);             /* Swap two pdl ptrs */
void   pdl_converttype( pdl** a, int targtype, /* Change type of a pdl */
                        Logical changePerl );
void   pdl_coercetypes( pdl** a, pdl **b, Logical changePerl ); /* Two types to same */
void   pdl_grow  ( pdl* a, int newsize);      /* Change pdl 'Data' size */
void   pdl_retype( pdl* a, int newtype);      /* Change pdl 'Datatype' value */
void** pdl_twod( pdl* x );                    /* Return 2D pointer to data array */

/* pdlsections.c */

int  pdl_get_offset(PDL_Long* pos, PDL_Long* dims, PDL_Long *incs, PDL_Long offset, int ndims);      /* Offset of pixel x,y,z... */
int  pdl_validate_section( int* sec, int* dims,           /* Check section */
                           int ndims );
void pdl_row_plusplus ( int* pos, int* dims,              /* Move down one row */
                        int ndims );
void pdl_subsection( char *y, char*x, int datatype,      /* Take subsection */
                 int* sec, int* dims, int *incs, int offset, int* ndims);
void pdl_insertin( char*y, int* ydims, int nydims,        /* Insert pdl in pdl */
                   char*x, int* xdims, int nxdims,
                   int datatype, int* pos);
double pdl_at( void* x, int datatype, PDL_Long* pos, PDL_Long* dims, /* Value at x,y,z,... */
             PDL_Long *incs, PDL_Long offset, int ndims);
void  pdl_set( void* x, int datatype, PDL_Long* pos, PDL_Long* dims, /* Set value at x,y,z... */
                PDL_Long *incs, PDL_Long offs, int ndims, double value);
void pdl_axisvals( pdl* a, int axis );               /* Fill with axis values */

/* Structure to hold pointers core PDL routines so as to be used by many modules */

struct Core {
    I32    Version;
    pdl*   (*SvPDLV)      ( SV*  );
    void   (*SetSV_PDL)   ( SV *sv, pdl *it );
#if defined(PDL_clean_namespace) || defined(PDL_OLD_API)
    pdl*   (*new)      ( );     /* make it work with gimp-perl */
#else
    pdl*   (*pdlnew)      ( );  /* renamed because of C++ clash */
#endif
    pdl*   (*tmp)         ( );
    pdl*   (*create)      (int type);
    void   (*destroy)     (pdl *it);
    pdl*   (*null)        ();
    SV*    (*copy)        ( pdl*, char* );
    pdl*   (*hard_copy)   ( pdl* );
    void   (*converttype) ( pdl**, int, Logical );
    void** (*twod)        ( pdl* );
    void*  (*smalloc)      ( int );
    int    (*howbig)      ( int );
    PDL_Long*   (*packdims)    ( SV* sv, int *ndims ); /* Pack dims[] into SV aref */
    void   (*setdims)     ( pdl* it, PDL_Long* dims, int ndims );
    void   (*unpackdims)  ( SV* sv, PDL_Long *dims,    /* Unpack */
                            int ndims );
    void   (*grow)        ( pdl* a, int newsize); /* Change pdl 'Data' size */
    void (*flushcache)( pdl *thepdl );	     /* flush cache */
    void (*reallocdims) ( pdl *it,int ndims );  /* reallocate dims and incs */
    void (*reallocthreadids) ( pdl *it,int ndims );
    void (*resize_defaultincs) ( pdl *it );     /* Make incs out of dims */

void (*thread_copy)(pdl_thread *from,pdl_thread *to);
void (*clearthreadstruct)(pdl_thread *it);
void (*initthreadstruct)(int nobl,pdl **pdls,int *realdims,int *creating,int npdls,
	pdl_errorinfo *info,pdl_thread *thread,char *flags);
int (*startthreadloop)(pdl_thread *thread,void (*func)(pdl_trans *),pdl_trans *);
int *(*get_threadoffsp)(pdl_thread *thread); /* For pthreading */
int (*iterthreadloop)(pdl_thread *thread,int which);
void (*freethreadloop)(pdl_thread *thread);
void (*thread_create_parameter)(pdl_thread *thread,int j,int *dims,
				int temp);
void (*add_deletedata_magic) (pdl *it,void (*func)(pdl *, int param), int param); /* Automagic destructor */

/* XXX NOT YET IMPLEMENTED */
void (*setdims_careful)(pdl *pdl);
void (*put_offs)(pdl *pdl,PDL_Long offs, double val);
double (*get_offs)(pdl *pdl,PDL_Long offs);
double (*get)(pdl *pdl,int *inds);
void (*set_trans_childtrans)(pdl *it, pdl_trans *trans,int nth);
void (*set_trans_parenttrans)(pdl *it, pdl_trans *trans,int nth);
pdl *(*make_now)(pdl *it);

pdl *(*get_convertedpdl)(pdl *pdl,int type);

void (*make_trans_mutual)(pdl_trans *trans);

/* Affine trans. THESE ARE SET IN ONE OF THE OTHER Basic MODULES
   and not in Core.xs ! */
void (*readdata_affine)(pdl_trans *tr);
void (*writebackdata_affine)(pdl_trans *tr);
void (*affine_new)(pdl *par,pdl *child,int offs,SV *dims,SV *incs);

/* Converttype. Similar */
void (*converttypei_new)(pdl *par,pdl *child,int type);

void (*trans_mallocfreeproc)(struct pdl_trans *tr);

void (*make_physical)(pdl *it);
void (*make_physdims)(pdl *it);
void (*pdl_barf) (const char* pat,...); /* Not plain 'barf' as this
                                  is a macro - KGB */
void (*make_physvaffine)(pdl *it);
void (*allocdata) (pdl *it);
PDL_Long (*safe_indterm)(PDL_Long dsz, PDL_Long at, char *file, int lineno);

float NaN_float;
double NaN_double;

void (*qsort_L) (PDL_Long *xx, int a, int b );
void (*qsort_ind_L) (PDL_Long *xx, int *ix, int a, int b );
void (*qsort_F) (PDL_Float *xx, int a, int b );
void (*qsort_ind_F) (PDL_Float *xx, int *ix, int a, int b );
void (*qsort_U) (PDL_Ushort *xx, int a, int b );
void (*qsort_ind_U) (PDL_Ushort *xx, int *ix, int a, int b );
void (*qsort_S) (PDL_Short *xx, int a, int b );
void (*qsort_ind_S) (PDL_Short *xx, int *ix, int a, int b );
void (*qsort_D) (PDL_Double *xx, int a, int b );
void (*qsort_ind_D) (PDL_Double *xx, int *ix, int a, int b );
void (*qsort_B) (PDL_Byte *xx, int a, int b );
void (*qsort_ind_B) (PDL_Byte *xx, int *ix, int a, int b );
void (*qsort_Q) (PDL_LongLong *xx, int a, int b );
void (*qsort_ind_Q) (PDL_LongLong *xx, int *ix, int a, int b );

  badvals bvals;  /* store the default bad values */
  void (*propogate_badflag) (pdl *it, int newval );  /* defined in bad.pd */
  void (*propogate_badvalue) (pdl *it);
  void (*children_changesoon)(pdl *it, int what);
  void (*changed)(pdl *it, int what, int recursing);
  void (*vaffinechanged)(pdl *it, int what);
  double (*get_pdl_badvalue)(pdl *it);
};

typedef struct Core Core;

Core *pdl__Core_get_Core(); /* INTERNAL TO CORE! DON'T CALL FROM OUTSIDE */

/* __PDLCORE_H */
#endif

