/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x100c12ff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc3c2c3ff, 0x100c12ff, 0x65586cff },
	[SchemeSel]  = { 0xc3c2c3ff, 0x8A7497ff, 0x6A4AA5ff },
	[SchemeUrg]  = { 0xc3c2c3ff, 0x6A4AA5ff, 0x8A7497ff },
};
