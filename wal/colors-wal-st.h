const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#100c12", /* black   */
  [1] = "#6A4AA5", /* red     */
  [2] = "#8A7497", /* green   */
  [3] = "#8A5FE2", /* yellow  */
  [4] = "#8F63E7", /* blue    */
  [5] = "#7897AE", /* magenta */
  [6] = "#67CC82", /* cyan    */
  [7] = "#948d97", /* white   */

  /* 8 bright colors */
  [8]  = "#65586c",  /* black   */
  [9]  = "#8d70c1",  /* red     */
  [10] = "#ac7ec8", /* green   */
  [11] = "#ae9bd4", /* yellow  */
  [12] = "#b2a0d6", /* blue    */
  [13] = "#8cb3ce", /* magenta */
  [14] = "#93d1a4", /* cyan    */
  [15] = "#c3c2c3", /* white   */

  /* special colors */
  [256] = "#100c12", /* background */
  [257] = "#c3c2c3", /* foreground */
  [258] = "#c3c2c3",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
