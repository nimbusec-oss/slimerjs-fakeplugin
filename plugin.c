#include <stdio.h>
#include "sdk/headers/npapi.h"
#include "sdk/headers/npfunctions.h"

// plugin instance functions (only stubs)
NPError NPP_New(NPMIMEType pluginType, NPP instance, uint16_t mode, int16_t argc, char* argn[], char* argv[], NPSavedData* saved) { return NPERR_NO_ERROR; }
NPError NPP_Destroy(NPP instance, NPSavedData** save) { return NPERR_NO_ERROR; }
NPError NPP_SetWindow(NPP instance, NPWindow* window) { return NPERR_NO_ERROR; }
NPError NPP_NewStream(NPP instance, NPMIMEType type, NPStream* stream, NPBool seekable, uint16_t* stype) { return NPERR_NO_ERROR; }
NPError NPP_DestroyStream(NPP instance, NPStream* stream, NPReason reason) { return NPERR_NO_ERROR; }
NPError NPP_GetValue(NPP instance, NPPVariable variable, void *value) { return NPERR_NO_ERROR; }
int16_t NPP_HandleEvent(NPP instance, void* event) { return (int16_t)false; }

// plugin global functions
NP_EXPORT(char*)       NP_GetPluginVersion() { return PLUGIN_VERSION; }
NP_EXPORT(const char*) NP_GetMIMEDescription() { return MIME_TYPES; }
NP_EXPORT(NPError)     NP_Initialize(NPNetscapeFuncs* bFuncs, NPPluginFuncs* pFuncs) {
	pFuncs->newp = NPP_New;
	pFuncs->destroy = NPP_Destroy;
	pFuncs->setwindow = NPP_SetWindow;
  pFuncs->newstream = NPP_NewStream;
  pFuncs->destroystream = NPP_DestroyStream;
  pFuncs->event = NPP_HandleEvent;
  pFuncs->getvalue = NPP_GetValue;
	return NPERR_NO_ERROR;
}

NP_EXPORT(NPError)     NP_GetValue(void* future, NPPVariable aVariable, void* aValue) {
  switch (aVariable) {
    case NPPVpluginNameString:
      *((char**)aValue) = PLUGIN_NAME;
      break;
    case NPPVpluginDescriptionString:
      *((char**)aValue) = PLUGIN_DESCRIPTION;
      break;
    default:
      return NPERR_INVALID_PARAM;
      break;
  }
  return NPERR_NO_ERROR;
}
