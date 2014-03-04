/*
 * SM Example 1
 *
 * ==========================================================================
 *
 *  Copyright 2006 Thorsten Klose (tk@midibox.org)
 *  Licensed for personal non-commercial use only.
 *  All other rights reserved.
 *
 * ==========================================================================
 */

#ifndef _MAIN_H
#define _MAIN_H

/////////////////////////////////////////////////////////////////////////////
// Global definitions
/////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
// Global Types
/////////////////////////////////////////////////////////////////////////////

// this is optional, but if you're used to booleans, it's a bit nicer:
#define TRUE  1
#define FALSE 0

// status of application
typedef union {
  struct {
    unsigned ALL:8;
  };
  struct {
    unsigned DISPLAY_UPDATE_REQ:1;  // requests a display update
    unsigned PLAY:1;  // requests a display update
  };
} app_flags_t;



/////////////////////////////////////////////////////////////////////////////
// Export global variables
/////////////////////////////////////////////////////////////////////////////
extern app_flags_t app_flags;

#endif /* _MAIN_H */
