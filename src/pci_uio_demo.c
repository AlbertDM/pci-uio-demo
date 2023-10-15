#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/pci.h>
// #include <linux/uio_driver.h>

/* Meta Information */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Albert Domingo Murillo");
MODULE_DESCRIPTION("PCIe UIO Demo Kernel Driver");

// PCI Device ID and Vendor ID
#define VENDOR_ID       0x1af4
#define DEVICE_ID       0x1000

// PCI ID List: All the compatible devices with this driver
static struct pci_device_id pci_ids[] = {
    { PCI_DEVICE(VENDOR_ID, DEVICE_ID), },
    { 0, }  // Empty element to indicate End of List
};

// Make the list known to the User Space
MODULE_DEVICE_TABLE(pci, pci_ids);

/**
 * @brief Function is called, when a PCI device is registered
 *
 * @param pdev  pointer to the PCI device
 * @param id    pointer to the corresponding ID table's entry
 *
 * @return      0 on success
 *              negative error code on failure
 */
static int pci_uio_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
{
    // Initialize your driver here
    printk("pci_uio_driver: Probe function.\n");

    return 0;
}

/**
 * @brief Function is called, when a PCI device is registered
 *
 * @param pdev  pointer to the PCI device
 *
 * @return      0 on success
 *              negative error code on failure
 */
static void pci_uio_remove(struct pci_dev *pdev)
{
    // Cleanup and release resources here
    printk("pci_uio_driver: Remove function.\n");

}

/* PCI driver struct */
static struct pci_driver pci_uio_driver = {
    .name = "pci_uio_demo",
    .id_table = pci_ids,
    .probe = pci_uio_probe,
    .remove = pci_uio_remove,
};

/**
 * @brief This function is called, when the module is loaded into the kernel
 */
static int __init pci_uio_init(void)
{
    printk("pci_uio_driver: Registering the PCI device.\n");
    int ret = pci_register_driver(&pci_uio_driver);
    if (ret < 0) {
        pr_err("pci_register_driver failed: %d\n", ret);
        return ret;
    }

    return 0;
}

/**
 * @brief This function is called, when the module is removed from the kernel
 */
static void __exit pci_uio_exit(void)
{
    printk("pci_uio_driver: Unregistering the PCI device.\n");
    pci_unregister_driver(&pci_uio_driver);
}

module_init(pci_uio_init);
module_exit(pci_uio_exit);

