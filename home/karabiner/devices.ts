import { ifDevice } from "karabiner.ts";

export const devices = {
  topre: [{ vendor_id: 2131, product_id: 308 }],
  pikatea: [{ vendor_id: 9025, product_id: 32822 }],
  macbook: [{ is_built_in_keyboard: true }],
  nuphy: [{ vendor_id: 6645, product_id: 12869 }],
  ergo: [{ vendor_id: 12951, product_id: 8208 }],
  nuphy_dongle: [{ vendor_id: 6645, product_id: 12871 }],
  mouse: [{ vendor_id: 5426, product_id: 123 }],
  qmkless: [
    { vendor_id: 6645 },
    { is_built_in_keyboard: true },
    { vendor_id: 1452, product_id: 834 },
  ],
  lemokey: [{ vendor_id: 13869 }],
} as const;

export function onDevice(name: keyof typeof devices) {
  return ifDevice([...devices[name]]);
}
